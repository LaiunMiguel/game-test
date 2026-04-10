extends Node2D


@onready var lig = $Luz
@onready var base_scale = lig.texture_scale
@onready var base_energy = lig.energy

@onready var close_lig = $closeLight
@onready var base_scale2 = close_lig.texture_scale
@onready var base_energy2 = close_lig.energy

var enemys_in_screen := []

var time := 0.0

func _process(delta: float) -> void:
	
	time += delta
	var fluct = sin(time * 5.0) * 0.02  # frecuencia y amplitud
	var fluct2 = sin(time * 7.0) * 0.04
	lig.texture_scale = base_scale + fluct
	close_lig.texture_scale = base_scale2 + fluct2
	
func change_light_lvl(time):
	
	var min_energy = 0.0001
	var adjusted_time = pow(time, 3.0)

	var energy1 = lerp(base_energy, min_energy, adjusted_time)
	var energy2 = lerp(base_energy, min_energy, adjusted_time)
	
	lig.energy = energy1
	close_lig.energy = energy2
	
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		enemys_in_screen.append(body)
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		enemys_in_screen.erase(body)
