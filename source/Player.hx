package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxAngle;

class Player extends FlxSprite
{
	override public function new(x:Float = 10, y:Float = 10)
	{
		super(x, y);

		makeGraphic(16, 16);
	}

	function move()
	{
		var up = FlxG.keys.anyPressed([UP, W]);
		var left = FlxG.keys.anyPressed([LEFT, A]);
		var down = FlxG.keys.anyPressed([DOWN, S]);
		var right = FlxG.keys.anyPressed([RIGHT, D]);

		var angle = 0;
		if (up)
		{
			angle = -90;
			if (left)
				angle -= 45;
			else if (right)
				angle += 45;
		}
		else if (down)
		{
			angle = 90;
			if (left)
				angle += 45;
			else if (right)
				angle -= 45;
		}
		else if (left)
			angle = 180;
		else if (right)
			angle = 0;

		if (up || down || left || right)
		{
			velocity.x = Math.cos(angle * FlxAngle.TO_RAD) * 200;
			velocity.y = Math.sin(angle * FlxAngle.TO_RAD) * 200;
		}
		else
			velocity.set(0, 0);
	}

	override function update(elapsed:Float)
	{
		move();

		x = PlayState.clamp(x, 0, FlxG.width);
		y = PlayState.clamp(y, 0, FlxG.height);

		super.update(elapsed);
	}
}
