package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class LightBeam extends FlxSprite
{
	var xDir = 1;
	var vel:Float;

	override public function new(x:Float = 0, width:Int = 40, vel:Float = 150)
	{
		super(x, 0);

		this.vel = vel;

		makeGraphic(width, FlxG.height, FlxColor.GRAY);
	}

	function move()
	{
		if (x <= 0 || x >= FlxG.width - width)
			xDir = -xDir;

		velocity.x = vel * xDir;
	}

	override function update(elapsed:Float)
	{
		move();

		x = PlayState.clamp(x, 0, FlxG.width);
		y = PlayState.clamp(y, 0, FlxG.height);

		super.update(elapsed);
	}
}
