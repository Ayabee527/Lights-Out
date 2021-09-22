package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.effects.FlxTrail;
import flixel.util.FlxColor;

enum EnemyType
{
	NORMX;
}

class Enemy extends FlxSprite
{
	public var type:EnemyType;
	public var trail:FlxTrail;

	var skin:FlxColor;
	var size:Int;
	var startX:Float;

	override public function new(x:Float, y:Float, type:EnemyType)
	{
		super(x, y);

		this.type = type;
		startX = x;

		switch (type)
		{
			case NORMX:
				skin = FlxColor.RED;
				size = 16;
			default:
				skin = FlxColor.GRAY;
				size = 16;
		}

		makeGraphic(size, size, skin);
		trail = new FlxTrail(this, null, 6, 0, 0.6, 0.1);
	}

	function normXAI()
	{
		if (startX > FlxG.width / 2 - width / 2)
		{
			velocity.x = FlxG.random.float(-600, -300);
			if (x < -width)
				kill();
		}
		else if (startX < FlxG.width / 2 - width / 2)
		{
			velocity.x = FlxG.random.float(600, 300);
			if (x > FlxG.width)
				kill();
		}
	}

	override function update(elapsed:Float)
	{
		switch (type)
		{
			case NORMX:
				normXAI();
			default:
				normXAI();
		}

		super.update(elapsed);
	}
}
