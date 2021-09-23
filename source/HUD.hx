package;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class HUD extends FlxGroup
{
	public var healthBar:FlxBar;

	var healthText:FlxText;
	var scoreText:FlxText;

	override public function new(player:Player)
	{
		super();

		healthBar = new FlxBar(10, 10, LEFT_TO_RIGHT, 150, 20, player, "health", 0,
			player.maxHealth).createGradientBar([FlxColor.RED, FlxColor.ORANGE], [FlxColor.GREEN, FlxColor.LIME], 1, 180, true);
		add(healthBar);

		healthText = new FlxText(0, 0, 0, "Health", 16);
		// healthText.color = FlxColor.CYAN;
		healthText.x = healthBar.x + (healthBar.width / 2) - healthText.width / 2;
		healthText.y = healthBar.y + (healthBar.height / 2) - healthText.height / 2;
		add(healthText);

		scoreText = new FlxText(10, 0, 0, "Score: 0", 16);
		scoreText.color = FlxColor.CYAN;
		scoreText.setBorderStyle(FlxTextBorderStyle.SHADOW, FlxColor.BLUE, 4);
		scoreText.y = healthBar.y + healthBar.height + 5;
		add(scoreText);
	}

	public function updateHUD(score:Float)
	{
		healthBar.updateBar();
		scoreText.text = "Score: " + score;
	}
}
