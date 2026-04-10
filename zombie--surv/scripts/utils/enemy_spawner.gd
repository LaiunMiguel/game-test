extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var enemyScene = preload("res://scenes/enemy.tscn")
@export var spanws: Array[Spawn_info] = []
var enemy_count = 0
var enemy_waiting_spawn = []

var time = 0 


func _on_timer_timeout() -> void:
	time += 1
	enemy_count = get_tree().get_nodes_in_group("enemies").size()

	for spawn_info in spanws:
		if time >= spawn_info.time_start and time <= spawn_info.time_end:
			spawn_info.spawn_delay_counter += 1

			if spawn_info.spawn_delay_counter >= spawn_info.enemy_spawn_delay:
				spawn_info.spawn_delay_counter = 0
				_spawn_enemys(spawn_info.enemy_num,spawn_info.enemyCap, spawn_info.enemyType)


func _spawn_enemys(cantEnemies: int,enemy_cap: int, enemyType: Array[EnemyData]) -> void:
	var spawned = 0
	while spawned < cantEnemies:
		if enemy_count < enemy_cap:
			var enemy_instance = enemyScene.instantiate()
			enemy_instance.enemy_data = enemyType.pick_random()
			enemy_instance.global_position = get_random_position()
			add_child(enemy_instance)
			enemy_instance.add_to_group("enemies")
			enemy_count += 1
		#else:
			#enemy_waiting_spawn.append(enemyType)
		spawned += 1

					

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
	
