extends Shooter

class_name SingleBulletShooter

var bullet

func shoot(owner: Node2D, weapon: WeaponData, target: Vector2) -> void:
	_bullet(owner, weapon, target)
	_bullet_with_player_stats(weapon)
	_shoot(owner, weapon)

func turretShoot(owner: Node2D, weapon: WeaponData, target: Vector2) -> void:
	_bullet(owner, weapon, target)
	_bullet_with_turret_stats(weapon)
	_shoot(owner, weapon)

func _bullet(owner: Node2D, weapon: WeaponData,target:Vector2) -> void:
	bullet = weapon.bullet_scene.instantiate()
	bullet.global_position = owner.global_position
	bullet.target = target

func _shoot(owner: Node2D,weapon:WeaponData) -> void:
	owner.add_child(bullet)
	if owner.has_method("play_sound"):
		owner.play_sound(weapon.shoot_sound)

func _bullet_with_player_stats(weapon) -> void:
	bullet.hp     = weapon.penetration
	bullet.damage = weapon.damage

func _bullet_with_turret_stats(weapon) -> void:
	bullet.hp     = weapon.turret_penetration
	bullet.damage = weapon.turret_damage