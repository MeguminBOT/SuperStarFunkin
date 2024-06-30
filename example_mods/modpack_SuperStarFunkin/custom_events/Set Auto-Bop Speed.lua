local bopSpeed = 0;
local intensity = 1;

function onEvent(name, value1, value2)

	if name == 'Set Auto-Bop Speed' then

		bopSpeed = value1;
		intensity = value2;

		if value2 == '' then

			intensity = 1;

		end
	end
end

function onStepHit()

	if curStep % bopSpeed == 0 then

		triggerEvent('Add Camera Zoom', 0.015 * intensity, 0.03 * intensity);

	end
end