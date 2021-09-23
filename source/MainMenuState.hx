package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRandom;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class MainMenuState extends FlxState
{
	var spawned:Bool = false;
	var enemies:FlxTypedGroup<Enemy>;
	var enemChances:Array<Float> = [0.9];
	var lights:FlxTypedGroup<LightBeam>;

	var title:FlxTypedGroup<FlxText>;
	var playButt:FlxButton;

	override function create()
	{
		super.create();

		lights = new FlxTypedGroup<LightBeam>();

		var light = new LightBeam(0, 40, 150);
		lights.add(light);
		var light = new LightBeam(FlxG.width - 41, 40, -150);
		lights.add(light);

		add(lights);

		title = createText(FlxG.height / 3, ["Lights", "Out"], 48, FlxColor.CYAN, FlxColor.BLUE);
		add(title);

		playButt = new FlxButton(0, 0, "Play!", () -> FlxG.switchState(new PlayState()));
		playButt.x = FlxG.width / 2 - playButt.width / 2;
		playButt.y = 3 * FlxG.height / 4 - playButt.height / 2;
		add(playButt);

		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);
	}

	public static function createText(y:Float = 0, array:Array<String>, size:Int = 16, color:FlxColor = FlxColor.WHITE, shadowColor:FlxColor = FlxColor.GRAY)
	{
		var group:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

		var last:FlxText = new FlxText(0, y, 0, "", size);
		last.x = FlxG.width / 2 - last.width / 2;
		last.y = y - last.height;
		group.add(last);

		for (i in 0...array.length)
		{
			var text = new FlxText(0, last.y + last.height + 1, 0, array[i], size);
			text.color = color;
			text.setBorderStyle(FlxTextBorderStyle.SHADOW, shadowColor, size / 4);
			text.x = FlxG.width / 2 - text.width / 2;
			group.add(text);
			last = text;
		}

		return group;
	}

	function spawner(delay:Float = 0.5)
	{
		if (!spawned)
		{
			spawned = true;

			var enemSpawn = new FlxRandom().weightedPick(enemChances);
			var enem:Enemy;
			switch (enemSpawn)
			{
				case 0:
					var leftOrRight:Bool = new FlxRandom().bool();
					if (leftOrRight)
					{
						enem = new Enemy(-12, new FlxRandom().float(0, FlxG.height - 12), NORMX);
					}
					else
					{
						enem = new Enemy(FlxG.width, new FlxRandom().float(0, FlxG.height - 12), NORMX);
					}
				default:
					var leftOrRight:Bool = new FlxRandom().bool();
					if (leftOrRight)
					{
						enem = new Enemy(-12, new FlxRandom().float(0, FlxG.height - 12), NORMX);
					}
					else
					{
						enem = new Enemy(FlxG.width, new FlxRandom().float(0, FlxG.height - 12), NORMX);
					}
			}
			enemies.add(enem);
			add(enem.trail);

			new FlxTimer().start(delay, resetSpawn);
		}
	}

	function resetSpawn(timer:FlxTimer):Void
	{
		spawned = false;
	}

	override function update(elapsed:Float)
	{
		spawner(0.25);

		super.update(elapsed);
	}
}
