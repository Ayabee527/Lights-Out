package;

import flixel.FlxG;
import flixel.FlxSprite;

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
			velocity.x = Math.cos(angle) * 100;
			velocity.y = Math.sin(angle) * 100;
		}
		else
			velocity.set(0, 0);
	}

	override function update(elapsed:Float)
	{
		move();

		super.update(elapsed);
	}
}
