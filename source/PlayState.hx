package;

import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;

class PlayState extends FlxState
{
	var player:Player;
	var lights:FlxTypedGroup<LightBeam>;

	override public function create()
	{
		lights = new FlxTypedGroup<LightBeam>();

		var light = new LightBeam();
		lights.add(light);

		add(lights);

		player = new Player();
		add(player);

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
	}
}
