function switch_prob = e_simulate_evan_nolearn(e,w,dis)

%epsilon = .1;
%w = .44;

switch_prob = zeros(1,4);
% door state: 1 means a door is open, 0 means it is closed
	% {1} is training phase, {2} is retraining phase
	% row 1 is state 2, row 2 is state 3
	% column is door 1, 2, and 3 - so in action space it corresponds to
	% whether the following actions are available: [3,4,5; 6,7,8]

% rewards are reward value in 3 terminal states (or 3 terminal actions)
% so, states [4,5,6]

% compute switch prob gives model switch probability (switching from action 1 to action 2 after
	% retraining phase) for set of parameters, doorstate and rewards

% reward revaluation
door_state{1} = [0,1,1; 1,0,1];
door_state{2} = [0,1,1; 1,0,1];
rewards{1} = [15, 30, 0];
rewards{2} = [45, 30, 0];
switch_prob(1) = compute_switch_prob(e,door_state, rewards, w);

% transition revaluation
door_state{1} = [0,1,1; 1,0,1];
door_state{2} = [1,0,1; 0,1,1];
rewards{1} = [15, 30, 0];
rewards{2} = [15, 30, 0];
switch_prob(2) = compute_switch_prob(e,door_state, rewards, w);

% policy revaluation
door_state{1} = [1,0,1; 0,1,1];
door_state{2} = [1,0,1; 0,1,1];
rewards{1} = [30, 0, 15];
rewards{2} = [30, 45, 15];
switch_prob(3) = compute_switch_prob(e,door_state, rewards, w);

% control
door_state{1} = [1,0,1; 0,1,1];
door_state{2} = [1,0,1; 0,1,1];
rewards{1} = [30, 0, 15];
rewards{2} = [45, 0, 15];

switch_prob(4) = compute_switch_prob(e,door_state, rewards, w);

target = [.66, .5, .46, .92];
mse = sum(target - switch_prob)^2;
if dis == 1
bar(switch_prob)
end


% simulate 





