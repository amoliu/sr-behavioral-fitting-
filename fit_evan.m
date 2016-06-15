%epsilon greedy

% cost function - param 1 is epsilon, param 2 is mixing weight (0 is sr, 1 is mb)
% look at ecost to see cost.m function
mixcost = @(params) ecost(params(1), params(2));

% grid search values
e_vec = 0:.0025:1;
w_vec = 0:.005:1; 

% matrix of mean squared errors for e,w combinations
mix_res = zeros(length(e_vec), length(w_vec));
for e_ind = 1:length(e_vec)
	for w_ind = 1:length(w_vec)
		mix_res(e_ind,w_ind) = mixcost([e_vec(e_ind),w_vec(w_ind)]);
		% mixcost func: mean squared error for parameter combination
	end
end

% get smallest mean squared error achieved
[emin_mse,eind1] = min(min(mix_res));

% get indice in matrix of best mean squared error
best_ind = find(emin_mse == mix_res);

% get indice of e and w in that matrix
[best_eind,best_wind] = ind2sub(size(mix_res), best_ind);

% get best value for e for mixture model, and best mixing weight
best_e = e_vec(best_eind); best_w = w_vec(best_wind);
% compute cost to verify it
mixcost([best_e,best_w])
target = [.66, .46, .5, .08];

% simulate and plot with target
figure(4)
hold on
e_simulate_evan_nolearn(best_e,best_w,1)
plot(target,'ro')

% get best mse when w restricted to 0 (sr)
[sr_mse, sr_ind] = min(mix_res(:,1));
% get epsilon for this mse
sr_e = e_vec(sr_ind)
% plot with target
plot(target,'ro')
figure(5)
hold on
e_simulate_evan_nolearn(sr_e,0,1)
plot(target,'ro')

% get best mse when w restricted to 1 (mb)...
figure(6)
hold on
[mb_mse, mb_ind] = min(mix_res(:,end));
% get best e for w = 1
mb_e = e_vec(mb_ind)
e_simulate_evan_nolearn(mb_e,1,1)
plot(target,'ro')










% %function res = fit_evan_nolearn()

% % soft max mixture model (mb + sr)
% mixcost = @(params) cost(params(1), params(2));

% % grid search to find  mean squared error for different parameter values
% b_vec = 0:.0025:.5; % inverse temp
% w_vec = 0:.005:1; % mixture weight
% mix_res = zeros(length(b_vec), length(w_vec));
% for b_ind = 1:length(b_vec)
% 	for w_ind = 1:length(w_vec)
% 		mix_res(b_ind,w_ind) = mixcost([b_vec(b_ind),w_vec(w_ind)]);
% 	end
% end

% % what's minimum mean squared error
% [min_mse,ind1] = min(min(mix_res));

% % indice in b/w matrix with best mean squared error
% best_ind = find(min_mse == mix_res);

% % get best b and best w
% [best_bind,best_wind] = ind2sub(size(mix_res), best_ind);
% best_b = b_vec(best_bind); best_w = w_vec(best_wind);
% % verify it has same cost
% mixcost([best_b,best_w])
% % target parameters for plotting purposes
% target = [.66, .46, .5, .08];

% % simulate with this
% figure(1)
% hold on
% simulate_evan_nolearn(best_b,best_w,1)

% % get best b for w = 0 (successor representation)
% [sr_mse, sr_ind] = min(mix_res(:,1));
% sr_b = b_vec(sr_ind)
% plot(target,'ro')
% figure(2)
% hold on
% simulate_evan_nolearn(sr_b,0,1)
% plot(target,'ro')

% % get best b for w = 1 (pure model based)
% figure(3)
% hold on
% [mb_mse, mb_ind] = min(mix_res(:,end));
% mb_b = b_vec(mb_ind)
% simulate_evan_nolearn(mb_b,1,1)
% plot(target,'ro')


