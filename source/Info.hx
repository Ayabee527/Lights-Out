package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.ui.FlxButton;

class Info extends FlxSubState
{
	override function create()
	{
		super.create();

		var group = MainMenuState.createText(20, [
			'Stay in the light(light gray rectangle)',
			'to survive and increase your score!',
			'',
			'[WASD] to move',
			'',
			'[RIGHT CLICK] to dash by sacrificing life',
			'',
			'Have Fun! :D'
		]);
		add(group);

		var backButt = new FlxButton(5, 5, "Back[ESC/I]", () -> close());
		add(backButt);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.I)
			close();

		super.update(elapsed);
	}
}
