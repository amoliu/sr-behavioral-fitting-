function switch_prob = compute_switch_prob(epsilon,door_state, rewards, w)

	% available actions in states 1,2, and 3
	available_actions = {[1,2], [3,4,5], [6,7,8]};

	% compute mb_values at end of training phase using rewards and doorstate ()
	model.rewards = rewards{1};
	model.door_state = door_state{1};
	Qmb = compute_mb_values(model);

	% compute sr at end of training phase

	% here, sr is 8 by 3 (8 actions: 1st and second level actions), (3 terminal actions-'actions in 3 terminal states (4,5,6)')
	sr = zeros(8,3); 

	% actions 3,4,5 experienced as leading to states 4,5,6 and 6,7,8 lead to 4,5,6 100% of time
	sr(3:8,:) = [eye(3); eye(3)];

	% get Qsr for those states - we need values to compute policies these states
	% to determine SR for level-one actions
	Qsr_bottom = sr*rewards{1}';

	% build successor representation for actions 1 and 2
	for s = 2:3 % for states 2 and 3
		% get available actions in this state
		this_state_aa = available_actions{s};
		% get actions corresponding to open doors in that state
		door_options = this_state_aa(door_state{1}(s-1,:) == 1);
		% what's the best available action in that state
		[max_val, max_ind] = max(Qsr_bottom(door_options));
		max_action = door_options(max_ind);
		% what's the non-best, but still available action in that state
		other_action = door_options(door_options ~= max_action);
		% use e-greedy policy  - action s-1 leads to followed by best action (1 - epsilon/2)% of time and other action epsilon/2 percent of time
		sr(s-1,:) = sr(max_action,:)*(1 - epsilon/2) + (epsilon/2)*sr(other_action,:);
	end

	% get Qsr pre values
	Qsr_pre = sr*rewards{1}';
	Q = (1-w)*Qsr_pre + w*Qmb';

	% get prob 1
	if Q(1) > Q(2)
		prob_correct = 1 - (epsilon/2);
	else
		prob_correct = epsilon/2;
	end

	if prob_correct < .75
		switch_prob = 10;
		return
	end

	% build updated values using new rewards
	% sr for bottom actions the same, and doesn't change for level-one actions because these aren't visited
	Qsr = sr*rewards{2}';

	% build model-based values using new doors as well as new rewards
	model.rewards = rewards{2};
	model.door_state = door_state{2};
	% get new model-based values
	Qmb = compute_mb_values(model);

	% get action 2 probability
	[mb_max_val, mb_max_ind] = max(Qmb(1:2));

	if mb_max_ind == 2
		mb_switch_prob = (1 - epsilon/2);
	else
		mb_switch_prob = epsilon/2;
	end

	% get action 2 probability
	[sr_max_val, sr_max_ind] = max(Qsr(1:2));

	if sr_max_ind == 2
		sr_switch_prob = (1 - epsilon/2);
	else
		sr_switch_prob = epsilon/2;
	end

	% switch prob
	switch_prob = w*mb_switch_prob + (1-w)*sr_switch_prob;	


