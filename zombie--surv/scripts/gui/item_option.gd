extends Control

var buyable_item : BuyableItem

@onready var item_icon := $Item/ItemIcon
@onready var lbl_name  := $lbl_name
@onready var lbl_price := $Price/lbl_price
@onready var lbl_des1  := $lbl_description
@onready var lbl_des2  := $lbl_description2
@onready var animated  := $AnimatedSprite2D
@onready var btn       := $Price/btn_buy

signal try_buy(item)

func setItem(item :BuyableItem):
	buyable_item = item
	item_icon.texture = buyable_item.item.icon
	lbl_name.text = buyable_item.item.name
	lbl_price.text = str(buyable_item.price) + " $"
	lbl_des1.text = buyable_item.item.firstLabel
	lbl_des2.text = buyable_item.item.secondLabel
	btn.visible = true
	animated.visible = false

func close_slot():
	btn.visible = false
	animated.visible = true
	animated.play("closing")
	

func _on_btn_buy_click_end() -> void:
	emit_signal("try_buy", self, buyable_item)
