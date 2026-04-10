extends CharacterBody2D

@export var enemy_data : EnemyData

var hp =10
var movement_speed = 100
var knockback = Vector2.ZERO
var screen_size

@onready var animated_sprite =$%AnimatedSprite2D
@onready var hit_box = $%HitBox
@onready var hurt_box = $%HurtBox
@onready var player = get_tree().get_first_node_in_group("player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")

var exp_gem = preload("res://scenes/money.tscn")
signal remove_from_array(object)

func _ready() -> void:
	var enemy_scale = Vector2(enemy_data.size_scale, enemy_data.size_scale)
	screen_size = get_viewport_rect().size
	hp = enemy_data.max_hp
	movement_speed = enemy_data.speed
	animated_sprite.frames = enemy_data.sprite_texture
	animated_sprite.scale = enemy_scale
	hurt_box.scale = enemy_scale
	hit_box.scale  = enemy_scale
	hit_box.damage = enemy_data.damage
	
	

func _physics_process(_delta) -> void:
	knockback = knockback.move_toward(Vector2.ZERO,enemy_data.knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	movement(direction)


func movement(direction: Vector2):
	velocity = direction * movement_speed
	velocity += knockback
	play_animation(direction)
	move_and_slide()

func play_animation(direction: Vector2):
	if direction.length() == 0:
		return

	if direction.y > 0:
		animated_sprite.play("Walk_down")
	else:
		animated_sprite.play("Walk_up")


	if direction.x > 0 and direction.y > 0:
		animated_sprite.play("Walk_down")
	elif direction.x > 0 and direction.y < 0:
		animated_sprite.play("Walk_up")



func _on_hurt(damage,angle,knockback_amount) -> void:
	hp -= damage
	knockback = angle * knockback_amount
	if hp <= 0:
		death_event()
	else:
		#snd_hurt.play()
		pass
		
func death_event():
	emit_signal("remove_from_array",self)
	player.add_to_score(1)
	#death_ani()
	
	if enemy_data.drop_chance > randf():
		var new_orb = exp_gem.instantiate()
		new_orb.global_position = global_position
		new_orb.value = enemy_data.exp_reward
		loot_base.call_deferred("add_child",new_orb)
	
	queue_free() 

func death_ani():
	var ani = enemy_data.death_sprite_texture
	var enemy_death = ani.instantiate()
	enemy_death.scale = animated_sprite.scale
	enemy_death.global_position = global_position
	enemy_death.flip_h = animated_sprite.flip_h
	get_parent().call_deferred("add_child",enemy_death)
	


func _on_far_enemy_timeout() -> void:
	var location_dif = global_position - player.global_position
	if  abs(location_dif.x)  > (screen_size.x/2) * 1.4 || abs(location_dif.y) > (screen_size.y/2) * 1.4:
		global_position = get_random_position()

	

func get_random_position() -> Vector2:
	var vpr = get_viewport_rect().size  * randf_range(1.1, 1.4)
	var top_left = Vector2(player.global_position.x - vpr.x/2,player.global_position.y - vpr.y/2)
	var top_right = Vector2(player.global_position.x + vpr.x/2,player.global_position.y - vpr.y/2)
	var bottom_left = Vector2(player.global_position.x - vpr.x/2,player.global_position.y + vpr.y/2)
	var bottom_right = Vector2(player.global_position.x + vpr.x/2,player.global_position.y + vpr.y/2)
	var points = ["up","down","left","right"].pick_random()
	var spawn_pos1 = Vector2.ZERO
	var spawn_pos2 = Vector2.ZERO
	
	match points:
		"up":
			spawn_pos1 = top_left
			spawn_pos2 = top_right
		"down":
			spawn_pos1 = bottom_left
			spawn_pos2 = bottom_right
		"left":
			spawn_pos1 = top_left
			spawn_pos2 = bottom_left
		"right":
			spawn_pos1 = top_right
			spawn_pos2 = bottom_right
		
	var x_spawn = randf_range(spawn_pos1.x,spawn_pos2.x)
	var y_spawn = randf_range(spawn_pos1.y,spawn_pos2.y)

	return Vector2(x_spawn,y_spawn)
