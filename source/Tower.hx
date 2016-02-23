package;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import haxe.Log;

/**
 * @author don
 */
class Tower extends FlxSprite
{
	// Public Members
	public var range:Float;
	public var fireRate:Float;
	public var damage:Float;
	public var currentTarget:Enemy;
	
	// Private Members
	private var defaultRange:Float;
	private var defaultFireRate:Float;
	private var fireCooldown:Float;
	private var defaultDamage:Float;
	private var autoTargetLock:Bool;
	
	public function new(?X:Float = 0, ?Y:Float = 0)
	{
		super(X, Y);
		init();
	}
	
	public function init(?Damage:Float=1.0, ?FireRate:Float=1.0, ?Range:Float=150, ?AutoTargetlock:Bool=false):Void
	{
		range = defaultRange = Range;
		fireRate = defaultFireRate = FireRate;
		damage = defaultDamage = Damage;
		autoTargetLock = AutoTargetlock;
	}
	
	override public function update(elapsed:Float):Void 
	{
		currentTarget = getEnemy();
		fireCooldown = fireCooldown < fireRate? fireCooldown += elapsed : fireRate;
		if (fireCooldown >= fireRate && currentTarget != null && currentTarget.alive)
		{
			fireCooldown = 0;
			fire();
		}
		
		super.update(elapsed);
	}
	
	private function fire():Void
	{
		var bullet = Reg.PS.bulletGroup.recycle(Bullet);
		var mid = getGraphicMidpoint();
		
		bullet.init(mid.x, mid.y, currentTarget, damage, 400);
	}
	
	// -------------------------------------------------------------------------
	// Helper Functions
	// -------------------------------------------------------------------------
	private function getEnemy():Enemy {
		var _target = null;
		
		for (enemy in Reg.PS.enemyGroup)
		{
			var _distance = FlxMath.distanceBetween(this, enemy);
			if (_distance <= range && enemy.alive)
			{
				_target = enemy;
				if (autoTargetLock) break;
			}
		}
		
		return _target;
	}
}