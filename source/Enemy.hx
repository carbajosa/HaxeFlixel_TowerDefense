package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxVelocity;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author ...
 */
class Enemy extends FlxSprite
{
	
	private var speed:Float;

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(16, 16);
		health = 3;
		speed = 10;
	}
	
	override public function update(elapsed:Float):Void 
	{
		FlxVelocity.moveTowardsObject(this, Reg.PS.towerGroup.getFirstAlive(), speed);
		
		if (health <= 0)
		{
			killMe();
		}
		
		super.update(elapsed);
	}
	
	private function killMe():Void
	{
		FlxTween.tween(this, { scale: 2 }, 0.5, { onComplete:function(_){
			kill();
		}} );
	}
	
}