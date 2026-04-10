extends Node2D

var weapon_turret: WeaponData
var activated: bool = false


@onready var player_enemies_in_light := %flashlight
@onready var cooldown := $cooldown 
@onready var weapon_sprite = $Sprite2D
@onready var audio_manager: AudioStreamPlayer2D = $audioManager



func _process(_delta: float) -> void:
	if activated:
		shootEnemys()


func change_turret(weapon: WeaponData) -> void:
	if weapon_turret == weapon:
		return

	weapon_turret = weapon
	weapon_sprite.texture = weapon_turret.turret_texture
	cooldown.wait_time = weapon_turret.turret_attackspeed
	activate_turret()
	
func shootEnemys() -> void:
	var enemys_in_range = player_enemies_in_light.enemys_in_screen
	if enemys_in_range.size() > 0 && cooldown.is_stopped():
		cooldown.start()
		var target = enemys_in_range.pick_random()
		if target:
			rotate_to_direction(target)
			var shooter_type = weapon_turret.shooter_type
			shooter_type.turretShoot(self, weapon_turret, target.global_position)


func activate_turret() -> void:
	if not weapon_turret:
		return
	visible = true
	activated = true
	

func deactivate_turret() -> void:
	visible = false
	activated = false


func _on_attack_speed_timeout() -> void:
	cooldown.stop()

func rotate_to_direction(target : Node2D) -> void:

	var target_pos = target.global_position
	var direction = (target_pos - global_position).normalized()
	var angle_to_target = direction.angle()

	weapon_sprite.global_position = global_position + direction 
	weapon_sprite.rotation = angle_to_target - get_parent().rotation
	weapon_sprite.flip_v = weapon_sprite.global_position.x < global_position.x


#Sound 
func play_sound(sound):
	audio_manager.stream = sound
	audio_manager.pitch_scale = randf_range(0.9, 1.1)
	audio_manager.play()
