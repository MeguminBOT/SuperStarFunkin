--[[

>>> Simple Event for Psych Engine to play a video during a song. // AutisticLulu

Value 1:
	Video file name

Value 2:
	Toggles the "inCutscene" property. [true/false]
	If left blank, it defaults to false.
]]

function onEvent(name, value1, value2)
	if name == 'Play Video' then
		if value2 == 'true' then
			setProperty('inCutscene', true)
		elseif value2 == 'false' then
			setProperty('inCutscene', false)
		else
			setProperty('inCutscene', false)
		end
		startVideo(value1)
	end
	return Function_Continue
end