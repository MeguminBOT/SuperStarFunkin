package states;

import lime.app.Application;
import states.editors.MasterEditorMenu;
import options.OptionsState;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '1.0b';
	public static var superStarVersion:String = '1.0'; // Discord RPC
	public static var curSelected:Int = 0;

	private var camMenu:FlxCamera;

	var menuItems:FlxTypedGroup<FlxSprite>;
	var optionShit:Array<String> = [
		'freeplay',
		'credits',
		'options'
	];

	override function create()
	{
		#if MODS_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		#if DISCORD_ALLOWED
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Main Menu", null);
		#end

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('background'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scale.set(0.5, 0.5);
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);
	
		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (num => option in optionShit)
		{
			var item:FlxSprite = createMenuItem(option);
		}

		var ssfVer:FlxText = new FlxText(1000, FlxG.height - 44, 0, "Superstar Funkin' v" + superStarVersion, 16);
		ssfVer.setFormat("Orbitron Medium", 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		ssfVer.letterSpacing = 2;
		add(ssfVer);

		var psychVer:FlxText = new FlxText(1000, FlxG.height - 24, 0, "Psych Engine v" + psychEngineVersion, 16);
		psychVer.setFormat("Orbitron Medium", 16, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		psychVer.letterSpacing = 2;
		add(psychVer);

		// Initial selection
		changeItem();

		super.create();
	}

	function createMenuItem(name:String):FlxSprite
	{
		var menuItem:FlxSprite = new FlxSprite(0, 0);
		menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_$name');
		menuItem.animation.addByPrefix('idle', '$name idle', 24, true);
		menuItem.animation.addByPrefix('selected', '$name selected', 24, true);
		menuItem.animation.play('idle');
		menuItem.scale.set(0.5, 0.5);
		menuItem.updateHitbox();
		menuItem.antialiasing = ClientPrefs.data.antialiasing;
		menuItems.add(menuItem);
		return menuItem;
	}

	var selectedSomethin:Bool = false;

	var timeNotMoving:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
			FlxG.sound.music.volume = Math.min(FlxG.sound.music.volume + 0.5 * elapsed, 0.8);

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
				changeItem(-1);

			if (controls.UI_DOWN_P)
				changeItem(1);

			#if desktop
			if (controls.justPressed('debug_1'))
			{
				selectedSomethin = true;
				FlxG.mouse.visible = false;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}
		
		if (controls.ACCEPT) {
			selectedSomethin = true;
			FlxG.sound.play(Paths.sound('confirmMenu'));
			var option:String = optionShit[curSelected];
			switch (option) {
				case 'freeplay':
					MusicBeatState.switchState(new FreeplayState());
				case 'credits':
					MusicBeatState.switchState(new CreditsState());
				case 'options':
					MusicBeatState.switchState(new OptionsState());
					OptionsState.onPlayState = false;
					if (PlayState.SONG != null) {
						PlayState.SONG.arrowSkin = null;
						PlayState.SONG.splashSkin = null;
						PlayState.stageUI = 'normal';
					}
			}
		}
	
		super.update(elapsed);
	}

	function changeItem(change:Int = 0)
	{
		curSelected = FlxMath.wrap(curSelected + change, 0, optionShit.length - 1);
		FlxG.sound.play(Paths.sound('scrollMenu'));

		for (item in menuItems)
		{
			item.animation.play('idle');
		}

		var selectedItem:FlxSprite;
		selectedItem = menuItems.members[curSelected];
		selectedItem.animation.play('selected');
	}
}
