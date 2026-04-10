extends Control

var world = "res://scenes/screens/world.tscn"

func _ready() -> void:
	var label = $Label
	animate_label(label)


func _on_btn_play_click_end() -> void:
	var _word = get_tree().change_scene_to_file(world)


func _on_btn_exit_click_end() -> void:
	get_tree().quit()

func animate_label(label: Label) -> void:
	var start_pos = label.position
	var up_pos = start_pos + Vector2(0, -10)
	var down_pos = start_pos + Vector2(0, 10)

	var tween = label.create_tween()
	tween.set_loops()
	tween.tween_property(label, "position", down_pos, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(label, "position", up_pos, 1).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)
