extends Node
class_name GeneralDB

var buyable_weapons: Array[WeaponData] = []
var infinite_items: Array[Resource] = []

var buyable_items: Array[BuyableItem] = []

func _ready():
	buyable_weapons = [
		preload("res://resource/weapons/shotgun.tres"),
		preload("res://resource/weapons/uzi.tres"),
		preload("res://resource/weapons/sniper.tres")

	]
	
	infinite_items = [
		preload("res://resource/Medikit.tres")
	]
