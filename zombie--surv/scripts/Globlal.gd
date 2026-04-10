extends Node

# Global Variables

# player variables
var player_current_stats = {
	"max_health": 100,
	"current_health": 100,
	"money": 0
}

var inventory: Dictionary = { 
	1: preload("res://resource/weapons/pistol.tres"),
	2:preload("res://resource/weapons/shotgun.tres"),
	3:	preload("res://resource/weapons/uzi.tres"),
	4:	preload("res://resource/weapons/sniper.tres")
	}


#difficulty variables
var spawn_rate = 1.0 
var enemy_health_multiplier = 1.0
var enemy_damage_multiplier = 1.0
var enemy_speed_multiplier = 1.0 


func apply(buyable_item: BuyableItem) -> void:
	
	var item = buyable_item.item
	if item is WeaponData:
		addWeaponToInventory(buyable_item.item)
	elif item is ConsumableData:
			restoreHealth(item.effect)
	elif item is WeaponUpgrade:
		item.apply_upgrade()

		

func addWeaponToInventory(weapon_data: WeaponData) -> void:
	var slot = inventory.size() + 1
	inventory.get_or_add(slot, weapon_data)
	General_DataBase.buyable_weapons.erase(weapon_data)

func changeHp(new_hp: int) -> void:
	player_current_stats["current_health"] = new_hp

func changeMoney(new_money: int) -> void:
	player_current_stats["money"] = new_money

func restoreHealth(health: int) -> void:
	var new_health = player_current_stats["current_health"] + health
	if new_health > player_current_stats["max_health"]:
		new_health = player_current_stats["max_health"]
	changeHp(new_health)


   
