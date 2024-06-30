local starsDuration = 1.5; -- how long stars take to fade

function onCreatePost()

	makeLuaSprite('vignette', 'stages/glamRock/superstarvig', 0, 0);
	setProperty('vignette.alpha', 0);
	setObjectCamera('vignette', 'other');

	for i = 1,3 do

		makeLuaSprite("stars" .. i, "stages/glamRock/superstars" .. i, 0, 0);
		setObjectCamera("stars" .. i, 'other');
		setProperty("stars" .. i .. ".alpha", 0);

		addLuaSprite("stars" .. i, false);

	end

	addLuaSprite('vignette', true);

end

function onEvent(name, value1, value2)

	if name == 'SuperstarEffect' then

		if value1 ~= '1' then

			setProperty('vignette.alpha', 1);
			setProperty('stars1.alpha', 1);

			doTweenAlpha('stars1Out', 'stars1', 0, starsDuration, 'quadInOut');
			doTweenAlpha('stars2In', 'stars2', 1, starsDuration, 'quadInOut');

		elseif value1 == '1' then

			setProperty('vignette.alpha', 0);

			for i = 1,3 do

				cancelTween("stars" .. i .. "In");
				cancelTween("stars" .. i .. "Out");

				setProperty("stars" .. i .. ".alpha", 0);

			end
		end
	end
end

function onTweenCompleted(tag)

	if tag == 'stars2In' then

		doTweenAlpha('stars2Out', 'stars2', 0, starsDuration, 'quadInOut');
		doTweenAlpha('stars3In', 'stars3', 1, starsDuration, 'quadInOut');

	elseif tag == 'stars3In' then

		doTweenAlpha('stars3Out', 'stars3', 0, starsDuration, 'quadInOut');
		doTweenAlpha('stars1In', 'stars1', 1, starsDuration, 'quadInOut');

	elseif tag == 'stars1In' then

		doTweenAlpha('stars1Out', 'stars1', 0, starsDuration, 'quadInOut');
		doTweenAlpha('stars2In', 'stars2', 1, starsDuration, 'quadInOut');

	end
end