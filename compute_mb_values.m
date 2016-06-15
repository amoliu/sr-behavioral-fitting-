function Qmb = compute_mb_values(model)

% recompute this at the start of each trial

for c = 1:2
	Qmb(c) = max(model.rewards(logical(model.door_state(c,:))));
end


Qmb(3:5) = model.rewards;
Qmb(6:8) = model.rewards;