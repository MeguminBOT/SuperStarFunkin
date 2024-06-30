function onCreatePost()

	makeLuaSprite('bg', 'stages/glamRock/glamrockbg', -500, -400);
	scaleObject('bg', 0.8, 0.8);
	addLuaSprite('bg', false);

	setProperty('camHUD.alpha', 0);

end