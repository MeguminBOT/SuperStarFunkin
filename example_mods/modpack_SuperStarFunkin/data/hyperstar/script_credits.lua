function onCreatePost()
	makeLuaText('header', 'Hyperstar:', 600, 1450, 425)
	setTextSize('header', 36)
	setTextColor('header', 'c0fffe')
	setTextAlignment('header', 'left')
	setObjectCamera('header', 'camOther')

	makeLuaText('credits', '', 600, 1450, 475)
	setTextSize('credits', 16)
	setTextColor('credits', 'F6C0FF')
	setTextAlignment('credits', 'left')
	setObjectCamera('credits', 'other')
	setTextString('credits', 'FrozenBlueberry - Glamrock Freddy Sprites, Background\nPouria_SFMs - Boyfriend Sprites\nPenove - Song\nZombie07King - Icons\nJustDom - Charting, Coding')
	
	makeLuaSprite('creditbg', '', 1440, 415)
	makeGraphic('creditbg', 600, 180, '000000')
	setProperty('creditbg.alpha', 0.5)
	setObjectCamera('creditbg', 'camOther')

	addLuaSprite('creditbg', false)
	addLuaText('header')
	addLuaText('credits')
end

function onBeatHit()
	if curBeat == 4 then
		doTweenX('header', 'header', 750, 2, 'elasticOut')
		doTweenX('credits', 'credits', 750, 2, 'elasticOut')
		doTweenX('creditbg', 'creditbg', 740, 2, 'elasticOut')

		runTimer('credithide', 10, 1)
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'credithide' then
		doTweenX('header', 'header', -1450, 2, 'elasticIn')
		doTweenX('credits', 'credits', -1450, 2, 'elasticIn')
		doTweenX('creditbg', 'creditbg', -1440, 2, 'elasticIn')
	end
end