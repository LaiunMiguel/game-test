extends Resource

class_name Spawn_info 


@export var time_start:int
@export var time_end:int

## The number of enemies to spawn at this time interval
@export var enemy_num:int 
## The delay between enemy spawns in seconds
@export var enemy_spawn_delay:int
## The types of enemys
@export var enemyType: Array[EnemyData]
## The maximum number of enemies that can be spawned at this time interval
@export var enemyCap:= 300


var spawn_delay_counter := 0
