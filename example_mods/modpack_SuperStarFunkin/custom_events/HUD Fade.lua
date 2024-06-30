function onEvent(name, value1, value2)

	if name == 'HUD Fade' then

		doTweenAlpha('hudfade', 'camHUD', value1, 60 / curBpm / 4 * value2, 'sineInOut');

	end
end