extends CharacterBody2D

var current_hp := 100.0
var max_hp := 100.0
var movement_speed := 60.0
var score := 0
var money := 0
var time_survived := 0
@onready var _animated_sprite = $AnimatedSprite2D
@onready var _kill_label = $GUILayer/GUI/KillsLabel

#GUI
@onready var health_bar = get_node("%HealthBar")
@onready var lblTimer = get_node("%lblTimer")
@onready var lbl_money = $%lbl_money
@onready var game_over_panel = get_node("%GameOverPanel")
@onready var btn_menu = get_node("%btn_menu")

#Weapon Sprite
@onready var weapon_sprite = get_node("%Weapon_sprite")
var weapon_distance = 16.0

# Weapon
@onready var weapon_handler = $weapons_handler

#flashlight
@onready var flashlight = %flashlight


func _ready() -> void:
	loadInventory()
	updateKills()
	update_hp_gui()
	update_money_gui()

func loadInventory():
	current_hp = Globlal.player_current_stats["current_health"]
	money = Globlal.player_current_stats["money"]

func updateKills():
	_kill_label.text = "Kills: " + str(score)




func _physics_process(_delta: float) -> void:
	movement()

func _process(_delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	$flashlight.rotation = direction.angle()
	update_weapon_texture(direction)
	
	
	
func update_weapon_texture(direction):
	weapon_sprite.global_position = global_position + direction * weapon_distance
	weapon_sprite.rotation = direction.angle()
	weapon_sprite.flip_v = weapon_sprite.global_position.x < global_position.x



func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	velocity = mov.normalized() * movement_speed
	play_animation(mov)
	move_and_slide()

func play_animation(direction: Vector2):
	if direction == Vector2.ZERO:
		_animated_sprite.play("Idle")
		_animated_sprite.z_index = 0
	elif abs(direction.x) > abs(direction.y):
		# Movimiento lateral
		_animated_sprite.flip_h = direction.x < 0
		_animated_sprite.play("Walk_side")
		_animated_sprite.z_index = 0
	elif direction.y > 0:
		_animated_sprite.play("Walk_down")
		_animated_sprite.z_index = 0
	else: # direction.y < 0
		_animated_sprite.play("Walk_up")
		_animated_sprite.z_index = 1



func _on_hurt(damage, _angle, _knockback) -> void:
	current_hp -= damage
	update_hp_gui()
	if current_hp <= 0:
		game_over()

func add_to_score(score_to_add):
	score += score_to_add
	updateKills()


func change_flashlight_light_lvl(time):
	flashlight.change_light_lvl(time)
	

func _on_grab_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("loot"):
		area.target = self


func _on_collect_area_area_entered(area: Area2D) -> void:
	if area.is_in_group("loot"):
		var value = area.collect()
		money += value 
		update_money_gui()


func game_over():
	get_tree().paused = true
	open_game_over_menu()

#GUI
func update_hp_gui():
	health_bar.value = current_hp
	health_bar.max_value = max_hp
	
func update_money_gui():
	lbl_money.text = "Money: " + str(money) + " $"

@warning_ignore("integer_division")
func change_time(argtime = 0):
	time_survived = argtime
	var get_m = time_survived / 60 
	var get_s = time_survived % 60
	if get_m < 10:
		get_m = "0" + str(get_m)
	if get_s < 10:
		get_s = "0" + str(get_s)
	lblTimer.text = str(get_m) + ":" + str(get_s)

	
func open_game_over_menu():
	var tween = game_over_panel.create_tween()
	game_over_panel.visible = true
	tween.tween_property(game_over_panel, "position", Vector2(220,50), 0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
	tween.play()

	
func _on_btn_menu_click_end() -> void:
	get_tree().paused = false
	var _level = get_tree().change_scene_to_file("res://scenes/screens/menu.tscn")
	
