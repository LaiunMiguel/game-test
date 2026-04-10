extends Node2D


@onready var player = $Player
@onready var timeScore = $TimeScore
@onready var scoreLabel = $UI/ScoreLabel
var score  = 0
var mobslist = []

var start_pos
var draggin = false

func _ready() -> void:
	mobslist = get_tree().get_nodes_in_group("mobs")
	timeScore.start()
	
func _process(delta: float) -> void:
	mobslist = get_tree().get_nodes_in_group("mobs")
	
	if mobslist.is_empty():
		finish_game()

func finish_game():
	get_tree().change_scene_to_file("res://2LVl.tscn")
	timeScore.stop()

func _input(event: InputEvent) -> void:
	if event.is_action("mouse_1") && !draggin:
		start_pos = get_global_mouse_position()
		draggin = !draggin
		
	if event.is_action_released("mouse_1"):
		var end_pos = get_global_mouse_position()
		var direction = end_pos - start_pos
		player.moveTo(direction)
		draggin = !draggin
		
	if event.is_action("reset"):
		get_tree().reload_current_scene()

func _on_time_score_timeout() -> void:
	score = score + 0.1
	timeScore.start()
	scoreLabel.text = str(score)
	
