extends Node
var inventory = []

var infinite_items = []
var buyable_weapons: Array[WeaponData] 
var current_weapons


func _ready():
	current_weapons = Globlal.inventory.values()
	buyable_weapons = General_DataBase.buyable_weapons
	infinite_items = General_DataBase.infinite_items
	

func get_choices(cantOfChoices:int = 4):
	var choice: BuyableItem
	var choices = []
	
	if buyable_weapons:
		var weapon = buyable_weapons.pick_random()
		choice = BuyableItem.new()
		choice.item = weapon
		choice.price = weapon.price
		choices.append(choice)

	while choices.size() < cantOfChoices:
		choice = BuyableItem.new()
		var buyable_item = generate_weapon_upgrade()
		choice.item = buyable_item
		choice.price = buyable_item.price
		choices.append(choice)
	return choices


func generate_weapon_upgrade() -> WeaponUpgrade:

	var weapon_to_upgrade = current_weapons.pick_random()
	var upgrade = WeaponUpgrade.new()
	upgrade.weapon = weapon_to_upgrade
	upgrade.generate_upgrade()
	return upgrade
