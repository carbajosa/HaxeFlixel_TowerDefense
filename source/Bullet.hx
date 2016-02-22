package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.FlxG;
import flixel.math.FlxVelocity;

/**
 * ...
 * @author ...
 */
class Bullet extends FlxSprite
{
	private var damage:Float;
	private var target:FlxSprite;
	private var speed:Float;

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		makeGraphic(8, 8);
	}
	
	public function init(X:Float, Y:Float, Target:FlxSprite, Damage:Float, Speed:Float):Void
	{
		reset(X, Y);
		damage = Damage;
		target = Target;
		speed = Speed;
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (!isOnScreen(FlxG.camera))
		{
			kill();
		}
		
		if (target != null)
		{
			FlxVelocity.moveTowardsObject(this, target, speed);
		}
		
		super.update(elapsed);
	}
	
}