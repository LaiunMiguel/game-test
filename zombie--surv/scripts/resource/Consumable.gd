# ConsumableData.gd
extends Resource
class_name ConsumableData


# Consumable Data

@export_group("Data")
@export var name: String = ""
@export var price: int = 0
@export var icon: Texture

# Consumable Description

@export_group("Description")
@export var description  : String      = "This is a consumable item."    
@export var firstLabel   : String 
@export var secondLabel  : String

# Consumable Effects
@export_group("Effects")
@export var effect: int = 0