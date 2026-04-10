extends Shooter
class_name ShotgunShooter

@export var pellets: int = 5
@export var spread_angle_deg: float = 20.0
var bullet

func shoot(owner: Node, weapon: WeaponData, target: Vector2) -> void:
	for i in pellets:
		_bullet(owner, weapon, target)
		_bullet_with_player_stats(weapon)
		_shoot(owner, weapon)


func turretShoot(owner: Node2D, weapon: WeaponData, target: Vector2) -> void:
	for i in pellets:
		_bullet(owner, weapon, target)
		_bullet_with_turret_stats(weapon)
		_shoot(owner, weapon)


## Private methods
func _bullet(owner: Node2D, weapon: WeaponData,target:Vector2) -> void:
	bullet = weapon.bullet_scene.instantiate()
	var base_angle = owner.global_position.angle_to_point(target)
	var offset = deg_to_rad(randf_range(-spread_angle_deg / 2, spread_angle_deg / 2))
	var final_angle = base_angle + offset
	var dir = Vector2(cos(final_angle), sin(final_angle))
	bullet.global_position = owner.global_position
	bullet.target = owner.global_position + dir * 1000

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