package;

import flixel.FlxState;

class PlayState extends FlxState
{
	var player:Player;

	override public function create()
	{
		player = new Player();
		add(player);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
