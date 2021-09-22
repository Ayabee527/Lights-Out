package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayState extends FlxState
{
	var player:Player;
	var lights:FlxTypedGroup<LightBeam>;
	var hud:HUD;

	override public function create()
	{
		lights = new FlxTypedGroup<LightBeam>();

		var light = new LightBeam();
		lights.add(light);

		add(lights);

		player = new Player();
		add(player);

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

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		player.color += 1;

		if (FlxG.overlap(player, lights))
			player.hurt(-0.03);
		else if (!FlxG.overlap(player, lights))
			player.hurt(0.03);
	}
}
