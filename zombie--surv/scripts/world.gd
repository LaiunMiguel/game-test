extends Node2D

@onready var _player := $Player
@onready var timer := $NextLevelTimer
@onready var total_time = 60
@onready var canvas_modulate: CanvasModulate = $CanvasModulate

var shop = "res://scenes/screens/shop.tscn"

## TODO - Implement a way to change the level or change the spawn 

# level idea 

# lvl 1.   Surive for 6 minutes , Spawn basic enemies
# lvl 2.   Survive for 3 minutes, Spawn basic enemies + fast enemies
# lvl 3.   Survive for 4 minutes, Spawn basic enemies + fast enemies + plant enemies
# lvl 4.   Survive for 5 minutes, Spawm fast enemies + plant enemies + cactus enemies
# lvl 5.   Survive for 6 minutes, all enemies + in the 6th minute a boss enemy spawns

# repeat all levels with increasing difficulty
# difficulty can be increased by increasing the spawn rate of enemies, increasing their health, and increasing their damage and speed


func _process(delta: float) -> void:
	var timer_left = timer.time_left
	var time = 1.0 - (timer_left / total_time)
	
	_player.change_time(timer_left)
	if timer_left <= 60:	
		var start_color = Color(0.01, 0.01, 0.01)
		var end_color = Color(1, 1, 1)
		var energy_color = start_color.lerp(end_color,time)	
		canvas_modulate.color = energy_color
		_player.change_flashlight_light_lvl(time)

func _on_next_level_timer_timeout() -> void:
	
	Globlal.changeHp(_player.current_hp)
	Globlal.changeMoney(_player.money)
	get_tree().change_scene_to_file(shop)
