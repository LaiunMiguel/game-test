extends Control

@onready var container = $HBoxContainer
var slots =  []
var selected = 0

func _ready() -> void:
	slots = container.get_children()
	slots[selected].is_selected()


func add_weapon(weapon: Texture, slot: int):
	if slots[slot-1]:
		slots[slot-1].change_item_texture(weapon)

func selectSlot(slot: int):
	slots[selected].is_not_selected()
	selected = slot - 1
	slots[selected].is_selected()
	
