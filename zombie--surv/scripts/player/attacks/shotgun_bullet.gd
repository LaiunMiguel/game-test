extends Area2D


var hp           = 1
var speed        = 1000
var damage       = 5
var knockback_amount = 100
var attack_size  = 1.0

var target = Vector2.ZERO
var angle  = Vector2.ZERO
 
@onready var player = get_tree().get_first_node_in_group("player")

signal remove_from_array(object)


func  _ready() -> void:
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)
	
func _physics_process(delta: float) -> void:
	position += angle * speed * delta

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		emit_signal("remove_from_array",self)
		queue_free()


func _on_timer_timeout() -> void:
	emit_signal("remove_from_array",self)
	queue_free()
