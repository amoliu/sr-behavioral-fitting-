close all
% we'll find parameters that minimize cost function (mean squared error)
% parameters: 
% w - mixing weight: 0 is full SR, 1 is full MB
% b1: scale Qvalue diff for ratings
mixcost = @(params) ida_cost(params(1), params(2));

% grid search values
w_vec = 0:.01:1;
%b0_vec = 0:.05:1;
b1_vec = .25:.01:.75;
% preallocate mtx to hold mean square error results
mix_res = zeros(length(w_vec),length(b1_vec));

% loop through grid
for w_ind = 1:length(w_vec)
	%w_ind
	%for b0_ind = 1:length(b0_vec)
		for b1_ind = 1:length(b1_vec)
			mix_res(w_ind,b1_ind) = mixcost([w_vec(w_ind),b1_vec(b1_ind)]);
		end
	%end
end

% minimum mean square error (mse) found
[min_mse,ind1] = min(min(min(mix_res)));

% index of min mse in 3D mix_res matrix
best_ind = find(min_mse == mix_res);

% indices in 3D matrix
[best_wind,best_b1ind] = ind2sub(size(mix_res), best_ind);

% parameter values corresponding to those indices
%best_b0 = b0_vec(best_b0ind); 
best_b1 = b1_vec(best_b1ind); best_w = w_vec(best_wind);

% target values (for plotting)
target = [0.04233389, 0.5187539, 0.4421187];


% plot results, (mix cost makes bar plots of simulations)
figure(1)
hold on
mixcost([best_w,best_b1])
plot(target,'ro')

% get best mse for w = 0
sr_res = squeeze(mix_res(1,:,:));
[sr_mse, sr_ind] = min(min(sr_res));
%best_srind = find(sr_mse == sr_res);
best_srb1ind = find(sr_mse == sr_res);
%[sr_b0ind,sr_b1ind] = ind2sub(size(sr_res), best_srind);
%sr_b0 = b0_vec(sr_b0ind); 
sr_b1 = b1_vec(best_srb1ind);

figure(2)
hold on
mixcost([0,sr_b1])
plot(target,'ro')

% get best mse for w = 1
mb_res = squeeze(mix_res(end,:,:));
[mb_mse, mb_ind] = min(min(mb_res));
best_mb1ind = find(mb_mse == mb_res);
%[mb_b1ind] = ind2sub(size(mb_res), best_mbind);
%mb_b0 = b0_vec(mb_b0ind); 
mb_b1 = b1_vec(best_mb1ind);

figure(3)
hold on
mixcost([1,mb_b1])
plot(target,'ro')






