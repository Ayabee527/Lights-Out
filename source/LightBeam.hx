package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

enum Alignment
{
	HORIZONTAL;
	VERTICAL;
}

class LightBeam extends FlxSprite
{
	var xDir = 1;
	var yDir = 1;
	var vel:Float;
	var type:Alignment;

	var w:Int;
	var h:Int;

	override public function new(xPos:Float = 0, width:Int = 40, vel:Float = 150, type:Alignment = VERTICAL)
	{
		super();

		this.vel = vel;
		this.type = type;

		switch (type)
		{
			case VERTICAL:
				w = width;
				h = FlxG.height;
				x = xPos;
				y = 0;
			case HORIZONTAL:
				w = FlxG.width;
				h = width;
				x = 0;
				y = xPos;
		}

		makeGraphic(w, h, FlxColor.GRAY);
	}

	function move()
	{
		switch (type)
		{
			case VERTICAL:
				if (x <= 0 || x >= FlxG.width - width)
					xDir *= -1;

				velocity.x = vel * xDir;
			case HORIZONTAL:
				if (y <= 0 || y >= FlxG.height - height)
					yDir *= -1;

				velocity.y = vel * yDir;
		}
	}

	override function update(elapsed:Float)
	{
		move();

		x = PlayState.clamp(x, 0, FlxG.width);
		y = PlayState.clamp(y, 0, FlxG.height);

		super.update(elapsed);
	}
}
