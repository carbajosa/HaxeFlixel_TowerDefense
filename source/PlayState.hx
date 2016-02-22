package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class PlayState extends FlxState
{
	// groups
	public var enemyGroup:FlxTypedGroup<Enemy>;
	public var bulletGroup:FlxTypedGroup<Bullet>;
	public var towerGroup:FlxTypedGroup<Tower>;
	
	override public function create():Void
	{
		super.create();
		Reg.PS = this;
		
		enemyGroup = new FlxTypedGroup<Enemy>();
		bulletGroup = new FlxTypedGroup<Bullet>();
		towerGroup = new FlxTypedGroup<Tower>();
		
		initEnemy();
		initBullet();
		initTower();
		
		add(enemyGroup);
		add(bulletGroup);
		add(towerGroup);
	}
	
	private function initEnemy():Void
	{
		var rand:Int = 0;
		for (i in 0...20)
		{
			rand = Math.round(Math.random() * 4);
			var enemy:Enemy = null;
			
			if (rand >= 3) {
				enemy = new Enemy(Math.random() * FlxG.width / 2, -32);
			} else if (rand == 2) {
				enemy = new Enemy(Math.random() * FlxG.width/2, FlxG.height + 32);
			} else if (rand == 1) {
				enemy = new Enemy(-32, Math.random() * FlxG.height / 2 );
			} else {
				enemy = new Enemy(FlxG.width + 32, Math.random() * FlxG.height / 2 );
			}
			
			
			
			enemyGroup.add(enemy);
		}
	}
	
	private function initBullet():Void
	{
		for (i in 0...50)
		{
			var bullet:Bullet = new Bullet(0, 0);
			bullet.kill();
			bulletGroup.add(bullet);
		}
	}
	
	private function initTower():Void
	{
		var tower:Tower = new Tower(FlxG.width / 2 - 16, FlxG.height / 2 - 16);
		towerGroup.add(tower);
	}
	
	private function checkCollision()
	{
		FlxG.collide(bulletGroup, enemyGroup, hurtEnemy);
	}
	
	private function hurtEnemy(bullet:Dynamic, enemy:Dynamic):Void
	{
		enemy.hurt(bullet.damage);
		bullet.kill();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		checkCollision();
	}
}
