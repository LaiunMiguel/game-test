extends Resource

class_name EnemyData


#Stats
@export_group("Stats")
@export var id                     : int          = 0
@export var name                   : String       = "Enemy"
@export var damage                 : float        = 5
@export var max_hp                 : int          = 100
@export var knockback_recovery     : float        = 3.5
@export var speed                  : float        = 100

#Rewards
@export_group("Rewards")
@export var exp_reward             : int          = 10
@export var drop_chance            : float        = 0.5

#Visuals
@export_group("Visuals")
@export var icon                   : Texture      = PlaceholderTexture2D.new()
@export var sprite_texture         : SpriteFrames = SpriteFrames.new()
@export var death_sprite_texture   : SpriteFrames = SpriteFrames.new()
@export var size_scale             : float        = 1.0 
@export var description            : String       = ""

#Sounds
@export_group("Sonidos")
@export var snd_on_hurt             : AudioStream
@export var snd_on_death            : AudioStream
