package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.effects.FlxFlicker;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRandom;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class GameOver extends FlxSubState
{
	var spawned:Bool = false;
	var lights:FlxTypedGroup<LightBeam>;

	override function create()
	{
		super.create();

		bgColor = FlxColor.BLACK;

		lights = new FlxTypedGroup<LightBeam>();

		var light = new LightBeam(0, 40, 150);
		lights.add(light);
		var light = new LightBeam(FlxG.width - 41, 40, -150);
		lights.add(light);

		var light = new LightBeam(0, 40, 150, HORIZONTAL);
		lights.add(light);
		var light = new LightBeam(FlxG.height - 41, 40, -150, HORIZONTAL);
		lights.add(light);

		add(lights);

		var text = MainMenuState.createText(FlxG.height / 3, ['Game Over'], 48, FlxColor.ORANGE, FlxColor.RED);
		add(text);

		var instr = MainMenuState.createText(FlxG.height / 2, ['Press [SPACE]', 'to retry!'], 24, FlxColor.ORANGE, FlxColor.RED);
		add(instr);

		var highScore = MainMenuState.createText(2 * FlxG.height / 3, ['Highscore: ' + PlayState.highScore], 16, FlxColor.ORANGE, FlxColor.RED);
		add(highScore);
	}

	override function update(elapsed:Float)
	{
		for (light in lights)
		{
			light.color++;
		}

		if (FlxG.keys.justPressed.SPACE)
		{
			close();
			PlayState.player.revive();
			PlayState.player.health = PlayState.player.maxHealth;
			FlxG.camera.flash(new FlxRandom().color(), 0.75);
			FlxFlicker.flicker(PlayState.player);
			PlayState.score = 0;
		}

		if (FlxG.camera.alpha < 1)
			FlxG.camera.alpha += 0.01;
		else
			FlxG.camera.alpha = 1;

		super.update(elapsed);
	}
}
