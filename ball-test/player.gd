extends CharacterBody2D


@onready var powerTimer = $StopPower
@export var health = 3 


var powerOn = false

func moveTo(vector: Vector2):
	velocity = vector * 3


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("power_activation"):
		powerTimer.start()
		powerOn = true
	
	if Input.is_action_just_released("power_activation"):
		powerTimer.stop()
		powerOn = false
		
	if powerOn:
		velocity = Vector2.ZERO
		
	move_and_slide()


func _on_stop_power_timeout() -> void:
	Input.action_release("power_activation")
