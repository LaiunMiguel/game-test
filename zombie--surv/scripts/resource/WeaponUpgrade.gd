extends Resource

class_name WeaponUpgrade
# Weapon
var weapon: WeaponData
var name: String
var icon
var price: int 

#Upgrade 1
var property_name: String
var firstUpgrade: float
var firstLabel: String

#Upgrade 2
var property_name2: String
var secondUpgrade: float
var secondLabel: String


func generate_upgrade() -> void:
	price = randi_range(10, 50) 
	var posible_upg = weapon.posible_upgrades
	var rng = RandomNumberGenerator.new()

	# weights for each upgrade type 
	var weights = PackedFloat32Array([
	2.5,  # damage
	1.0,  # penetration
	0.5,  # reload_speed
	0.3,  # attackspeed
	0.0,  # max_ammo
	2.5,  # turret_damage
	0.5,  # turret_penetration
	0.3   # turret_attackspeed
])

	var upgrade1 = posible_upg[rng.rand_weighted(weights)]
	var upgrade2 = posible_upg[rng.rand_weighted(weights)]

	property_name  = upgrade1
	property_name2 = upgrade2
	firstUpgrade = get_upgrade_value(upgrade1)
	secondUpgrade = get_upgrade_value(upgrade2)
	firstLabel = "%s: +%.1f" % [upgrade1.capitalize(), firstUpgrade]
	secondLabel = "%s: +%.1f" % [upgrade2.capitalize(), secondUpgrade]
	icon = weapon.icon
	name = weapon.name + " Upgrade"


func get_upgrade_value(partUpgraded: String):
	match partUpgraded:
		"damage":
			return randi_range(1, 5)
		"turret_damage":
			return randi_range(1, 5)
		"penetration":
			return randi_range(1, 2)
		"turret_penetration":
			return randi_range(1, 2)
		"reload_speed":
			return randf_range(0.1, 0.2)
		"attackspeed":
			return 0.1
		"turret_attackspeed":
			return 0.1
		_: 
			return 0

func apply_upgrade() -> void:
	#Assigns param value to the given param property. If the property does not exist or the given param value's type doesn't match, nothing happens.
	weapon.set(property_name, (weapon.get(property_name) + firstUpgrade))
	weapon.set(property_name2, (weapon.get(property_name2) + secondUpgrade))
