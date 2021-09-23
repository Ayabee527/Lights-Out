package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class Pause extends FlxSubState
{
	override function create()
	{
		super.create();

		FlxG.camera.alpha = 1;

		var paused = MainMenuState.createText(FlxG.height / 3 - 24, ['PAUSED'], 48, FlxColor.CYAN, FlxColor.BLUE);
		add(paused);

		var instr = MainMenuState.createText(FlxG.height / 3 - 24, [' ', ' ', ' ', ' ', 'Press [ESC]', 'to unpause'], 24, FlxColor.CYAN, FlxColor.BLUE);
		add(instr);

		var pauseButt = new FlxButton(0, 0, "Unpause!", () -> close());
		pauseButt.x = FlxG.width / 2 - pauseButt.width / 2;
		pauseButt.y = 4 * FlxG.height / 5 - pauseButt.height / 2;
		add(pauseButt);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ESCAPE)
			close();

		super.update(elapsed);
	}
}
