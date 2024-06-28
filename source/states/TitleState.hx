package states;

import backend.WeekData;
import flixel.input.keyboard.FlxKey;

import states.StoryMenuState;
import states.OutdatedState;
import states.MainMenuState;

class TitleState extends MusicBeatState
{
	public static var initialized:Bool = false;
	public static var closedState:Bool = false;
	public static var updateVersion:String = '';
	var mustUpdate:Bool = false;

	override public function create():Void
	{
		Paths.clearStoredMemory();
		ClientPrefs.loadPrefs();
		Language.reloadPhrases();

		super.create();

		#if CHECK_FOR_UPDATES
		if(ClientPrefs.data.checkForUpdates && !closedState) {
			trace('checking for update');
			var http = new haxe.Http("https://raw.githubusercontent.com/MeguminBOT/SuperStarFunkin/main/gitVersion.txt");

			http.onData = function (data:String) {
				updateVersion = data.split('\n')[0].trim();
				var curVersion:String = MainMenuState.superStarVersion.trim();
				trace('version online: ' + updateVersion + ', your version: ' + curVersion);
				if(updateVersion != curVersion) {
					trace('versions arent matching!');
					mustUpdate = true;
				}
			}

			http.onError = function (error) {
				trace('error: $error');
			}

			http.request();
		}
		#end

		if(!initialized) {
			if(FlxG.save.data != null && FlxG.save.data.fullscreen) {
				FlxG.fullscreen = FlxG.save.data.fullscreen;
				//trace('LOADED FULLSCREEN SETTING!!');
			}
			persistentUpdate = true;
			persistentDraw = true;
		}

		if (FlxG.save.data.weekCompleted != null) {
			StoryMenuState.weekCompleted = FlxG.save.data.weekCompleted;
		}

		FlxG.mouse.visible = false;
		#if FREEPLAY
		MusicBeatState.switchState(new FreeplayState());
		#elseif CHARTING
		MusicBeatState.switchState(new ChartingState());
		#else
		if(FlxG.save.data.flashing == null && !FlashingState.leftState) {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new FlashingState());
		} else {
			if (initialized)
				startIntro();
			else {
				new FlxTimer().start(1, function(tmr:FlxTimer)
				{
					startIntro();
				});
			}
		}
		#end
	}

	function startIntro()
	{
		if (!initialized && FlxG.sound.music == null)
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0.5);

		Conductor.bpm = 100;
		persistentUpdate = true;
		initialized = true;
		Paths.clearUnusedMemory();
	}

	var transitioning:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;

		if (initialized && !transitioning) {
			transitioning = true;

			new FlxTimer().start(1, function(tmr:FlxTimer)
			{
				if (mustUpdate) {
					MusicBeatState.switchState(new OutdatedState());
				} else {
					MusicBeatState.switchState(new MainMenuState());
				}
				closedState = true;
			});
		}
		super.update(elapsed);
	}
}