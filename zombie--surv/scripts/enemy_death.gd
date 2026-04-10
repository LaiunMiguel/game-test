extends AnimatedSprite2D



func _ready() -> void:
	play("Death")


func _on_animation_finished() -> void:
	queue_free()
