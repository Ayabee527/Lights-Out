package;

import flixel.group.FlxGroup;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;

class HUD extends FlxGroup
{
	var healthBar:FlxBar;

	override public function new(player:Player)
	{
		super();

		healthBar = new FlxBar(10, 10, LEFT_TO_RIGHT, 150, 20, player, "health", 0,
			player.maxHealth).createGradientBar([FlxColor.RED, FlxColor.ORANGE], [FlxColor.GREEN, FlxColor.LIME], 1, 180, true);
		add(healthBar);
	}

	public function updateHUD()
	{
		healthBar.updateBar();
	}
}
