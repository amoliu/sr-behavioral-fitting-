function Qmb = compute_mb_values(model)

% recompute this at the start of each trial

% possible_door_states = dec2bin(0:(2^3)-1)=='1';
% % compute model-based choices values (actions 1 and 2)
% Qmb = zeros(1,8);
% for c = 1:2
% % incrementally add value of each door state, weighted by probability
% 	action_val = 0;
% 	for d = 1:size(possible_door_states,1)
% 		this_door_state = possible_door_states(d,:);

% 		% get probability of this door state
% 		individual_door_open_probs = model.door_state(c,:);
% 		individual_door_closed_probs = 1 - model.door_state(c,:);
% 		prob_this_door_state = prod([individual_door_open_probs(this_door_state==1) individual_door_closed_probs(this_door_state==0)]);

% 		% action value conditioned on this door state
% 		q_this_door_state = max(model.rewards(logical(this_door_state)));
% 		if isempty(q_this_door_state) q_this_door_state = 0; end

% 		action_val = action_val + q_this_door_state*prob_this_door_state;
% 	end
% 	Qmb(c) = action_val;
% end

% update model-based Q values for second level actions
%keyboard

for c = 1:2
	Qmb(c) = max(model.rewards(logical(model.door_state(c,:))));
end


Qmb(3:5) = model.rewards;
Qmb(6:8) = model.rewards;