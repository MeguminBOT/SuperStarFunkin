package states;

class CreditsState extends MusicBeatState
{
	private static inline var SCALE_FACTOR:Float = 0.5;
	private static inline var ANIMATION_FPS:Int = 24;

	private var curSelected:Int = -1;

	private var descItems:FlxTypedGroup<FlxSprite>;
	private var peopleItems:FlxTypedGroup<FlxSprite>;
	private var iconItems:FlxTypedGroup<FlxSprite>;
	private var peopleShit:Array<String> = ['blue', 'zombie', 'lulu', 'springy', 'penove', 'dom', 'pouria'];

	override function create()
	{
		#if DISCORD_ALLOWED
		DiscordClient.changePresence("Credits Menu", null);
		#end

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('creditsmenu/bg'));
		bg.antialiasing = ClientPrefs.data.antialiasing;
		bg.scale.set(SCALE_FACTOR, SCALE_FACTOR);
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		var tablet:FlxSprite = new FlxSprite().loadGraphic(Paths.image('creditsmenu/tablet'));
		tablet.antialiasing = ClientPrefs.data.antialiasing;
		tablet.scale.set(SCALE_FACTOR, SCALE_FACTOR);
		tablet.updateHitbox();
		tablet.screenCenter();
		add(tablet);

		peopleItems = new FlxTypedGroup<FlxSprite>();
		add(peopleItems);

		descItems = new FlxTypedGroup<FlxSprite>();
		add(descItems);

		iconItems = new FlxTypedGroup<FlxSprite>();
		add(iconItems);

		for (name in peopleShit) {
			createPeopleItem(name);
			createDescItem(name);
			createIconItem(name);
		}

		changeItem();

		super.create();
	}

	function createPeopleItem(name:String)
	{
		var sprite = new FlxSprite(0, 0);
		sprite.frames = Paths.getSparrowAtlas('creditsmenu/people/$name');
		sprite.animation.addByPrefix('idle', '$name idle', ANIMATION_FPS, true);
		sprite.animation.addByPrefix('highlight', '$name highlight', ANIMATION_FPS, true);
		sprite.animation.play('idle');
		sprite.scale.set(SCALE_FACTOR, SCALE_FACTOR);
		sprite.updateHitbox();
		sprite.antialiasing = ClientPrefs.data.antialiasing;
		peopleItems.add(sprite);
	}

	function createDescItem(name:String)
	{
		var sprite = new FlxSprite().loadGraphic(Paths.image('creditsmenu/description/$name'));
		sprite.scale.set(SCALE_FACTOR, SCALE_FACTOR);
		sprite.updateHitbox();
		sprite.antialiasing = ClientPrefs.data.antialiasing;
		descItems.add(sprite);
	}

	function createIconItem(name:String)
	{
		var sprite = new FlxSprite(0, 0).loadGraphic(Paths.image('creditsmenu/icon/$name'));
		sprite.scale.set(SCALE_FACTOR, SCALE_FACTOR);
		sprite.updateHitbox();
		sprite.antialiasing = ClientPrefs.data.antialiasing;
		iconItems.add(sprite);
	}

	override function update(elapsed:Float)
	{
		if (controls.UI_UP_P || controls.UI_DOWN_P) {
			changeItem(controls.UI_UP_P ? -1 : 1);
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		super.update(elapsed);
	}

	function changeItem(change:Int = 0)
	{
		curSelected = FlxMath.wrap(curSelected + change, 0, peopleShit.length - 1);
		FlxG.sound.play(Paths.sound('scrollMenu'));

		for (item in peopleItems) {
			item.animation.play('idle');
		}

		for (item in descItems) {
			item.visible = false;
		}

		for (item in iconItems) {
			item.visible = false;
		}

		var selectedItem = peopleItems.members[curSelected];
		selectedItem.animation.play('highlight');

		var selectedItemDesc = descItems.members[curSelected];
		selectedItemDesc.visible = true;

		var selectedItemIcon = iconItems.members[curSelected];
		selectedItemIcon.visible = true;
	}
}