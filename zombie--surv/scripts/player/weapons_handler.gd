extends Node2D


#Inventory
var inventory_dictionary: Dictionary = {}
var current_slot: int = 1

#GUI
@onready var hud_inventory = get_node("%HudInventory")
@onready var ammo_label = get_node("%BulletsLabel")
@onready var ammo_bar   = get_node("%AmmoBar")
@onready var reload_bar = get_node("%ReloadBar")
@onready var weapon_sprite = get_node("%Weapon_sprite")

#Current Weapon
var current_weapon: WeaponState
var current_ammo: int
var max_ammo:int
var is_reloading = false
var stop_shooting = false
@onready var shoot_sound = $"../AudioStreamPlayer2D"
@onready var reload_timer = $ReloadTimer

#Turrets
@onready var turretHandler = %Torretas
@onready var turrets: Dictionary = {
	1: $%Turret,
	2: $%Turret2,
	3: $%Turret3,
	4: $%Turret4
}

func _ready() -> void:
	loadInventory()


func loadInventory():
	inventory_dictionary = Globlal.inventory.duplicate()
	for slot in inventory_dictionary:
		var weapon_data = inventory_dictionary[slot]
		var weapon = WeaponState.new()
		weapon.weapon_data = weapon_data
		weapon.current_ammo = weapon_data.max_ammo
		inventory_dictionary[slot] = weapon
		max_ammo = weapon_data.max_ammo
		hud_inventory.call_deferred("add_weapon", weapon_data.icon, slot)
		turrets[slot].change_turret(weapon_data)

	current_weapon = inventory_dictionary[current_slot]
	current_ammo = current_weapon.current_ammo
	weapon_sprite.texture = current_weapon.weapon_data.texture
	turrets[current_slot].deactivate_turret()
	update_ammo_ui()
	update_ammo_bar_values()	


func _process(delta: float) -> void:
	turretHandler.rotate(0.1 * delta)
	shoot_weapons()
	if is_reloading and reload_bar.visible:
		reload_bar.value += delta

func _unhandled_input(event):
	if event.is_action_pressed("reload"):
		reload_weapon()
	elif Input.is_action_just_pressed("inventory_1"):
		change_to_item_in_slot(1)
	elif Input.is_action_just_pressed("inventory_2"):
		change_to_item_in_slot(2)
	elif Input.is_action_just_pressed("inventory_3"):
		change_to_item_in_slot(3)
	elif Input.is_action_just_pressed("inventory_4"):
		change_to_item_in_slot(4)


func change_to_item_in_slot(slot: int):
	if current_slot == slot:
		return

	if inventory_dictionary.has(slot):
		var old_weapon = WeaponState.new()
		old_weapon.weapon_data = current_weapon.weapon_data
		old_weapon.current_ammo = current_ammo
		inventory_dictionary[current_slot] = old_weapon
		current_weapon = inventory_dictionary[slot]
		swap_turret(slot)
		current_slot = slot
		change_weapon()
		hud_inventory.selectSlot(slot)


func change_weapon():
	stop_reloading()
	current_ammo = current_weapon.current_ammo
	max_ammo = current_weapon.weapon_data.max_ammo
	weapon_sprite.texture = current_weapon.weapon_data.texture
	update_ammo_ui()
	update_ammo_bar_values()

func swap_turret(turret_to_deactivated: int):
	turrets[current_slot].activate_turret()
	turrets[turret_to_deactivated].deactivate_turret()
	

func shoot_weapons():
	if Input.is_action_pressed("clickShoot"):
		if can_shoot():
			stop_shooting = true
			shoot_weapon()
			update_ammo_ui()
			await get_tree().create_timer(current_weapon.weapon_data.attackspeed).timeout
			stop_shooting = false

func shoot_weapon() -> void:
	var weapon_data = current_weapon.weapon_data
	var target = get_global_mouse_position()
	weapon_data.shooter_type.shoot(self, weapon_data, target)
	current_ammo -= 1
	update_ammo_ui()

func can_shoot() -> bool:
	return current_ammo > 0 && !stop_shooting && !is_reloading


func update_ammo_ui():
	ammo_label.text = str(current_ammo) + "/" + str(max_ammo)
	ammo_bar.value = current_ammo

func update_ammo_bar_values():
	ammo_bar.max_value = max_ammo
	ammo_bar.value = current_ammo

func stop_reloading():
	is_reloading = false
	reload_timer.stop()
	reload_bar.visible = false


func reload_weapon():
	if reload_timer.is_stopped() && current_weapon:
		is_reloading = true
		reload_bar.visible = true
		reload_bar.value = 0
		reload_bar.max_value = current_weapon.weapon_data.reload_speed
		reload_timer.wait_time = current_weapon.weapon_data.reload_speed
		reload_timer.start()


func _on_reload_timer_timeout() -> void:
	current_ammo = max_ammo
	update_ammo_ui()
	reload_bar.visible = false
	is_reloading = false
	reload_timer.stop()


func play_sound(sound):
	shoot_sound.stream = sound
	shoot_sound.play()
