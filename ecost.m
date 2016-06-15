function mse = ecost(epsilon,w)
% evan cost function with e greedy

% proportion that switch for each trial type (reward, transition, policy, control)
target = [.66, .46, .5, .08];
% simulate switch probability for each trial type for a particular 
model_switch_probs = e_simulate_evan_nolearn(epsilon,w,0);
% compute mean squared error between model switch probabilities and proportions
mse = sum((target - model_switch_probs).^2);