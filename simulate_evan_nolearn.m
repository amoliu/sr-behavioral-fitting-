function switch_prob = simulate_evan_nolearn(b,w,dis)

%epsilon = .1;
%w = .44;

switch_prob = zeros(1,4);
% reward revaluation
door_state{1} = [0,1,1; 1,0,1];
door_state{2} = [0,1,1; 1,0,1];
% rewards in each terminal state
rewards{1} = [15, 30, 0];
rewards{2} = [45, 30, 0];
switch_prob(1) = compute_switch_prob_sm(b,door_state, rewards, w);

% transition revaluation
door_state{1} = [0,1,1; 1,0,1];
door_state{2} = [1,0,1; 0,1,1];
rewards{1} = [15, 30, 0];
rewards{2} = [15, 30, 0];
switch_prob(2) = compute_switch_prob_sm(b,door_state, rewards, w);

% policy revaluation
door_state{1} = [1,0,1; 0,1,1];
door_state{2} = [1,0,1; 0,1,1];
rewards{1} = [30, 0, 15];
rewards{2} = [30, 45, 15];
switch_prob(3) = compute_switch_prob_sm(b,door_state, rewards, w);

% control
door_state{1} = [1,0,1; 0,1,1];
door_state{2} = [1,0,1; 0,1,1];
rewards{1} = [30, 0, 15];
rewards{2} = [45, 0, 15];

switch_prob(4) = compute_switch_prob_sm(b,door_state, rewards, w);

target = [.66, .5, .46, .92];
mse = sum(target - switch_prob)^2;
if dis == 1
bar(switch_prob)
end


% simulate 





