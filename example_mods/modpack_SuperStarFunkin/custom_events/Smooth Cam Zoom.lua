function onEvent(name, value1, value2)

	if name == 'Smooth Cam Zoom' then

		setProperty('defaultCamZoom', value1);
		doTweenZoom('camzoom', 'camGame', value1, 60 / curBpm / 4 * value2, 'sineInOut');

	end
end