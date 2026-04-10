extends TextureRect

@onready var slot_label = $lbl_number_slot
@export  var slot_number = 0

var not_select = preload("res://assets/gui/Weapon Slot.png")
var select = preload("res://assets/gui/Selected Weapon.png")

func  _ready() -> void:
	slot_label.text = str(slot_number)

func change_item_texture(item_texture):
	$Item_Texture.texture = item_texture
	
func is_selected():
	texture = select

func is_not_selected():
	texture = not_select
