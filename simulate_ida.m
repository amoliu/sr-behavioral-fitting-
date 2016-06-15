function score = simulate_ida(w,b1,rewards,next_state)


% in addition to parameter values, simulate ida takes in next_state
% and rewards cell arrays
% index i in next-state vector provides the state to which i leads
% rewards provide the reward at states 5 and 6
% both are cell arrays.  index 1 of cell is training phase, index 2 is re-training phase


% sr is 6x2 - rows correspond to 6 states. columns correspond to states 5 and 6 (that contain rewards)
% sr(i,j) will encode probability of winding up in state j conditioned upon visiting state i
sr = zeros(6,2);


% asymptotic value at end of phase 1 - see written equation
% 5 and 6 lead to themselves
sr(5,1) = 1;
sr(6,2) = 1;
% back up state predictions for experienced transitions in this phase
for s = 4:-1:1
	sr(s,:) = sr(next_state{1}(s),:);
end

% SR valeus for end os phase 1 at the end of phase 1 - th
Qsr_pre = sr*rewards{1}';

% MB values for end of phase 1 - reward backs up for experienced transitios
% 1 value for each state
Qmb_pre = zeros(6,1);
% 5 and 6 are just reward value
Qmb_pre(5:6) = rewards{1};
% value iteration
for s = 4:-1:1
	Qmb_pre(s) = Qmb_pre(next_state{1}(s));
end
% Q values for pre are 
Q_pre = w*Qmb_pre + (1-w)*Qsr_pre;

% rating 1
rating1 = b1*(Q_pre(2)/(Q_pre(1)+Q_pre(2)));

% phase 2
% update sr for states 3 and 4
for s = 4:-1:3
	sr(s,:) = sr(next_state{2}(s),:);
end

% update sr value
Qsr_post = sr*rewards{2}';

% get mb value
Qmb_post = zeros(6,1);
Qmb_post(5:6) = rewards{2};
for s = 4:-1:1
	Qmb_post(s) = Qmb_post(next_state{2}(s));
end

% values for post
Q_post = w*Qmb_post + (1-w)*Qsr_post;

% convert to rating using a linear function
rating2 = b1*(Q_post(2)/(Q_post(1)+Q_post(2)));

score = (rating2 - rating1);

