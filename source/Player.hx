package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxAngle;
import flixel.util.FlxTimer;

class Player extends FlxSprite
{
	public var maxHealth = 10;
	public var dashing:Bool = false;

	var vel:Float = 200;

	override public function new(x:Float = 10, y:Float = 10)
	{
		super(x, y);

		health = maxHealth;

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

		if ((up || down || left || right) && !dashing)
		{
			velocity.x = Math.cos(angle * FlxAngle.TO_RAD) * vel;
			velocity.y = Math.sin(angle * FlxAngle.TO_RAD) * vel;
		}
		else if (!dashing)
			velocity.set(0, 0);
	}

	function dash(delay:Float = 0.25)
	{
		if (FlxG.mouse.justPressedRight && !dashing)
		{
			dashing = true;
			angularVelocity = 360;
			var angle = FlxAngle.angleBetweenMouse(this);
			velocity.x = Math.cos(angle) * vel * 3;
			velocity.y = Math.sin(angle) * vel * 3;
			new FlxTimer().start(delay, stopDash);
		}
	}

	function stopDash(timer:FlxTimer):Void
	{
		dashing = false;
		angularVelocity = 0;
		angle = 0;
	}

	override function update(elapsed:Float)
	{
		move();
		dash();

		x = PlayState.clamp(x, 0, FlxG.width);
		y = PlayState.clamp(y, 0, FlxG.height);
		health = PlayState.clamp(health, 0, maxHealth);

		super.update(elapsed);
	}
}
