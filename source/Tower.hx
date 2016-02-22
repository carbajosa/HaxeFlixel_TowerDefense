package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.math.FlxVelocity;
import flixel.math.FlxMath;

/**
 * ...
 * @author ...
 */
class Tower extends FlxSprite
{
	
	private var range:Float;
	private var damage:Float;
	private var fireRate:Float;
	private var fireCooldown:Float;
	private var currentTarget:Enemy;

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		
		range = 400;
		fireRate = 0.75;
		fireCooldown = 0;
		currentTarget = null;
		damage = 3;
		
		makeGraphic(32, 32);
	}
	
	override public function update(elapsed:Float):Void 
	{
		currentTarget = getEnemy();
		
		if (canFire(elapsed) && currentTarget != null && currentTarget.alive)
		{
			fireCooldown = 0;
			fire();
		}
		
		
		super.update(elapsed);
	}
	
	private function getEnemy():Enemy
	{
		var _target = null;
		
		for (enemy in Reg.PS.enemyGroup)
		{
			var distance = FlxMath.distanceBetween(this, enemy);
			if (distance < range && enemy.alive)
			{
				_target = enemy;
				break;
			}
		}
		
		return _target;
	}
	
	private function canFire(elapsed:Float):Bool
	{
		if (fireCooldown <= fireRate)
		{
			fireCooldown += elapsed;
		}
		
		if (fireCooldown >= fireRate)
		{
			return true;
		} else {
			return false;
		}
	}
	
	private function fire():Void
	{
		var bullet = Reg.PS.bulletGroup.recycle(Bullet);
		var mid = getGraphicMidpoint();
		
		bullet.init(mid.x, mid.y, currentTarget, damage, 400);
	}
	
}