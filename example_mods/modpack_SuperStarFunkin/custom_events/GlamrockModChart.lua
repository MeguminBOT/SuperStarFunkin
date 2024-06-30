local movement = 40; -- amount of movement from center of each note
local duration = 1.5; -- duration of each movement (half of loop)
local noteSpacing = 120; -- bullshit workaround

function onEvent(name, value1, value2)

	if name == 'GlamrockModChart' then

		for i = 0,7 do

			runTimer("noteOffset" .. i, 0.1 * i, 1);

		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)

	for i = 0,3 do

		if tag == "noteOffset" .. i then

			local note = 80 + noteSpacing * i;
			noteTweenX("noteIn" .. i, i, note + movement, duration, 'quadInOut');

		end
	end

	for i = 4,7 do

		if tag == "noteOffset" .. i then

			local note = 625 + noteSpacing * (i - 3);
			noteTweenX("noteIn" .. i, i, note + movement, duration, 'quadInOut');

		end
	end
end

function onTweenCompleted(tag)

	for i = 0,3 do

		local note = 80 + noteSpacing * i;
		if tag == "noteIn" .. i then

			noteTweenX("noteOut" .. i, i, note - movement, duration, 'quadInOut');

		elseif tag == "noteOut" .. i then

			noteTweenX("noteIn" .. i, i, note + movement, duration, 'quadInOut');

		end
	end

	for i = 4,7 do

		local note = 625 + noteSpacing * (i - 3);
		if tag == "noteIn" .. i then

			noteTweenX("noteOut" .. i, i, note - movement, duration, 'quadInOut');

		elseif tag == "noteOut" .. i then

			noteTweenX("noteIn" .. i, i, note + movement, duration, 'quadInOut');

		end
	end
end

-- hi i'm dom and i fucking hate i variables