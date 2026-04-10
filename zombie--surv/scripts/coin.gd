extends Area2D

@export var value = 1

var target = null
var speed  = -1

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $AudioStreamPlayer2D


const TEXTURES := {
	"low": preload("res://assets/sprites/Items/GoldCoin.png"),
	"mid": preload("res://assets/sprites/Items/Gold.png"),
	"high": preload("res://assets/sprites/Items/moneyBag.png")
}

func _ready() -> void:
	if value <= 25:
		sprite.texture = TEXTURES["low"]
	elif value <= 50:
		sprite.texture = TEXTURES["mid"]
	else:
		sprite.texture = TEXTURES["high"]
		
	sprite.z_index = 5

		
func _physics_process(delta: float) -> void:
	if target != null:
		global_position = global_position.move_toward(target.global_position,speed)
		speed += 2*delta

func collect() -> int:
	sound.play()
	collision.call_deferred("set","disabled",true)
	sprite.visible = false
	return value


func _on_audio_stream_player_2d_finished() -> void:
	queue_free()
