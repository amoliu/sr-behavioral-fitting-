function [mse, sim] = ida_cost(w,b1)

% cost function to be minimized
% % parameters: 
% w - mixing weight: 0 is full SR, 1 is full MB
% b0 and b1: map Q values to rating using linear function (b0 is intercept, b1 is slope)

% target values: control, reward, transition revaluation
target = [0.04233389, 0.5187539, 0.4421187];

% vector to hold simulated ratings
sim = zeros(1,3);

% in addition to parameter values, simulate ida takes in nex_state
% and rewards cell arrays
% index i in next-state vector provides the state to which i leads
% rewards provide the reward at states 5 and 6
% both are cell arrays.  index 1 of cell is training phase, index 2 is re-training phase

% simulate

% reward revaluation
next_state{1} = [3,4,5,6];
next_state{2} = [3,4,5,6];

rewards{1} = [100,1];
rewards{2} = [1,100];

sim(2) = simulate_ida(w,b1,rewards,next_state);

% transition revaluation
next_state{1} = [3,4,5,6];
next_state{2} = [3,4,6,5];

rewards{1} = [100,1];
rewards{2} = [100,1];

sim(3) = simulate_ida(w,b1,rewards,next_state);

% control
next_state{1} = [3,4,5,6];
next_state{2} = [3,4,5,6];

rewards{1} = [100,1];
rewards{2} = [100,1];

sim(1) = simulate_ida(w,b1,rewards,next_state)

 bar(sim); %make plot?

% compute mean square error of simulated rating and target rating
mse = sum((sim - target).^2);

