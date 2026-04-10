extends Control

var world = "res://scenes/screens/world.tscn"
var money : int
var reroll_cost := 20
var capacity := 4

@onready var lbl_money = $lbl_money
@onready var shop_options = $shop_optionsHandler
@onready var reroll: ColorRect = $Reroll
@onready var lbl_reroll_price: Label = $Reroll/lbl_reroll_price
@onready var btn_roll: Button = $Reroll/btn_roll
@onready var slots = {
	1: $Slot1,
	2: $Slot2,
	3: $Slot3,
	4: $Slot4
}

func _ready() -> void:
	money = Globlal.player_current_stats["money"]
	upadate_lbl_money()
	upadete_lbl_reroll_price()
	load_shop()

func load_shop() -> void:
	var slot = 1
	var buyable_items = shop_options.get_choices(4)
	for buyable_item in buyable_items:
		var shop_slot = slots[slot]
		shop_slot.setItem(buyable_item)
		slot += 1

func _on_try_buy(shop_slot: Node,buyable_item):
	if money >= buyable_item.price:
		money -= buyable_item.price
		upadate_lbl_money()
		Globlal.apply(buyable_item)
		shop_slot.close_slot()
	else: 
		pass
	

#Buttons Effects

func _on_btn_next_click_end() -> void:
	Globlal.changeMoney(money)
	var _word = get_tree().change_scene_to_file(world)

func _on_btn_roll_click_end() -> void:

	if money >= reroll_cost:
		btn_roll.disabled = true
		money -= reroll_cost
		reroll_cost += reroll_cost * 0.1
		upadate_lbl_money()
		upadete_lbl_reroll_price()
		_animateReroll()
		load_shop()
	else:
		pass
	
func _on_btn_exit_click_end() -> void:
	get_tree().quit()

#GUI 
func upadate_lbl_money() -> void:
	lbl_money.text = "Money: " + str(money) + " $"

func upadete_lbl_reroll_price() -> void:
	lbl_reroll_price.text = str(reroll_cost) + " $"

func _animateReroll() -> void:
	var original_position = reroll.position
	var tween := reroll.create_tween()
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_BACK) 
	tween.tween_property(reroll, "scale", Vector2(1.1, 1.1), 0.1)
	tween.tween_property(reroll, "position", reroll.position + Vector2(-5, -5), 0.1)
	tween.tween_property(reroll, "position", original_position, 0.2)
	tween.tween_property(reroll, "scale", Vector2(1, 1), 0.2)
	tween.tween_callback(_on_reroll_animation_complete)

func _on_reroll_animation_complete() -> void:
	btn_roll.disabled = false

	
