package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxRandom;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class PlayState extends FlxState
{
	public static var player:Player;

	var lights:FlxTypedGroup<LightBeam>;
	var hud:HUD;
	var spawned = false;
	var enemChances = [0.9];
	var enemies:FlxTypedGroup<Enemy>;
	var tween:FlxTween;
	var pauseButt:FlxButton;

	public static var black:FlxSprite;
	public static var score:Float = 0;

	override public function create()
	{
		lights = new FlxTypedGroup<LightBeam>();

		var light = new LightBeam();
		lights.add(light);

		add(lights);

		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);

		pauseButt = new FlxButton(0, 5, "Pause!", () -> openSubState(new Pause()));
		pauseButt.x = FlxG.width - pauseButt.width - 5;
		add(pauseButt);

		black = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		black.setPosition(0, 0);
		black.alpha = 0;
		add(black);

		player = new Player();
		add(player);
		add(player.trail);

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

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		hud.updateHUD(score);

		if (score <= 1)
			score = 1;

		if (FlxG.keys.justPressed.ESCAPE)
			openSubState(new Pause());

		black.alpha = (player.health / 10) + 0.1;

		if (!player.alive)
			openSubState(new GameOver());

		if (!player.alive)
			player.trail.visible = false;
		else
			player.trail.visible = true;

		spawner(0.25);

		for (enemy in enemies)
			if (!enemy.alive)
			{
				enemies.remove(enemy);
				remove(enemy.trail);
			}

		if (FlxG.overlap(player, lights))
		{
			player.hurt(-0.05);
			score += 1;
		}
		else if (!FlxG.overlap(player, lights))
		{
			score -= 1;
			if (!player.dashing)
				player.hurt(0.02);
			else
				player.hurt(0.1);
		}

		if (FlxG.overlap(player, enemies) && !FlxFlicker.isFlickering(player) && !player.dashing)
		{
			score -= 100;
			FlxFlicker.flicker(player, 0.25);
			FlxG.camera.flash(FlxColor.RED, 0.25);
			FlxG.camera.shake(0.01, 0.25);
			if (player.health > player.maxHealth / 2)
				player.hurt(player.health / 2);
			else
				player.hurt(player.maxHealth / 2);
		}
	}
}
