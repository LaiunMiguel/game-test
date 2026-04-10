extends Resource

#class to make weapons

class_name WeaponData


#ID
@export var id           : int         = 0

# Weapon visuals and sounds
@export_group("visuals and sounds")
@export var icon          : Texture     = PlaceholderTexture2D.new()
@export var texture       : Texture     = PlaceholderTexture2D.new()
@export var turret_texture: Texture     = PlaceholderTexture2D.new()
@export var shoot_sound   : AudioStream 


# Weapon properties
@export_group("Properties")
@export var name         : String      = "Weapon"
@export var price        : int         = 0
@export var damage       : float       = 5
@export var penetration  : int         = 1
@export var reload_speed : float       = 1
@export var attackspeed  : float       = 1
@export var max_ammo     : int         = 10
@export var shooter_type : Shooter     = null # Shooter is a base class for different shooting behaviors
@export var bullet_scene : PackedScene 

# Weapon turret properties
@export var turret_damage       : float       = 5
@export var turret_penetration  : int         = 1
@export var turret_attackspeed  : float       = 1

# Weapon Description
@export_group("Description")
@export var description  : String      = "This is a weapon."    
@export var firstLabel   : String 
@export var secondLabel  : String

var posible_upgrades = ["damage","penetration","reload_speed","attackspeed","max_ammo","turret_damage","turret_penetration","turret_attackspeed"]