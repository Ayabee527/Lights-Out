package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	var player:Player;
	var lights:FlxTypedGroup<LightBeam>;
	var hud:HUD;
	var spawned = false;
	var enemChances = [0.9];
	var enemies:FlxTypedGroup<Enemy>;

	override public function create()
	{
		lights = new FlxTypedGroup<LightBeam>();

		var light = new LightBeam();
		lights.add(light);

		add(lights);

		player = new Player();
		add(player);

		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);

		hud = new HUD(player);
		add(hud);

		super.create();
	}

	public static function clamp(val:Float, min:Float, max:Float)
	{
		if (val < min)
			val = min;
		else if (val > max)
			val = max;
		return val;
	}

	function spawner(delay:Float = 0.5)
	{
		if (!spawned)
		{
			spawned = true;

			var enemSpawn = new FlxRandom().weightedPick(enemChances);
			switch (enemSpawn)
			{
				case 0:
					var leftOrRight:Bool = new FlxRandom().bool();
					if (leftOrRight)
					{
						var enem = new Enemy(-12, new FlxRandom().float(0, FlxG.height - 12), NORMX);
						enemies.add(enem);
					}
					else
					{
						var enem = new Enemy(FlxG.width, new FlxRandom().float(0, FlxG.height - 12), NORMX);
						enemies.add(enem);
					}
				default:
					var leftOrRight:Bool = new FlxRandom().bool();
					if (leftOrRight)
					{
						var enem = new Enemy(-12, new FlxRandom().float(0, FlxG.height - 12), NORMX);
						enemies.add(enem);
					}
					else
					{
						var enem = new Enemy(FlxG.width, new FlxRandom().float(0, FlxG.height - 12), NORMX);
						enemies.add(enem);
					}
			}

			new FlxTimer().start(delay, resetSpawn);
		}
	}

	function resetSpawn(timer:FlxTimer):Void
	{
		spawned = false;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		spawner(0.25);

		for (enemy in enemies)
			if (!enemy.alive)
				enemies.remove(enemy);

		if (FlxG.overlap(player, lights))
			player.hurt(-0.05);
		else if (!FlxG.overlap(player, lights))
			player.hurt(0.02);

		if (FlxG.overlap(player, enemies) && !FlxFlicker.isFlickering(player))
		{
			FlxFlicker.flicker(player, 0.25);
			FlxG.camera.flash(FlxColor.RED, 0.25);
			FlxG.camera.shake(0.01, 0.25);
			player.hurt(player.health / 2);
		}
	}
}
