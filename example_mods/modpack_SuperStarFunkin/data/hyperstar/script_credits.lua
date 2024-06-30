function onCreatePost()

	makeLuaText('header', "SUPERSTAR FUNKIN':", 600, 1450, 425);
	setTextSize('header', 50);
	setTextColor('header', 'c0fffe');
	setTextAlignment('header', 'left');
	setObjectCamera('header', 'other');

	makeLuaText('credits', "FrozenBlueberry - Glamrock Freddy Sprites, Background\n\nPouria_SFMs - Boyfriend Sprites\n\nPenove - Song\n\nZombie07King - Icons\n\nJustDom - Charting, Coding", 600, 1450, 475);
	setTextSize('credits', 25);
	setTextColor('credits', 'f6c0ff');
	setTextAlignment('credits', 'left');
	setObjectCamera('credits', 'other');

	makeLuaSprite('creditbg', "", 1440, 415);
	makeGraphic('creditbg', 600, 600, '000000');
	setProperty('creditbg.alpha', 0.5);
	setObjectCamera('creditbg', 'other');

	addLuaSprite('creditbg', false);
	addLuaText('header');
	addLuaText('credits');

	runTimer('creditshow', 2, 1);

end

function onTimerCompleted(tag, loops, loopsLeft)

	if tag == 'creditshow' then

		doTweenX('header', 'header', 750, 1, 'quadOut');
		doTweenX('credits', 'credits', 750, 1, 'quadOut');
		doTweenX('creditbg', 'creditbg', 740, 1, 'quadOut');

		runTimer('credithide', 11, 1);

	elseif tag == 'credithide' then

		doTweenX('header', 'header', 1450, 1, 'quadIn');
		doTweenX('credits', 'credits', 1450, 1, 'quadIn');
		doTweenX('creditbg', 'creditbg', 1440, 1, 'quadIn');

	end
end