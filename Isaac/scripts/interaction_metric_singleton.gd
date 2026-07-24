extends Node

const FILE := "user://save.dat"
var states:Dictionary = {}

func _ready():
	if FileAccess.file_exists(FILE):
		states = FileAccess.open(FILE, FileAccess.READ).get_var()

func has_state(key:String) -> bool:
	return states.has(key)

func get_state(key:String) -> int:
	return states.get(key, 0)

func set_state(key:String, value:int):
	states[key] = value

func save():
	FileAccess.open(FILE, FileAccess.WRITE).store_var(states)
	
#example usage:
#InteractionMetricSingleton.set_state("coins", 25)
#InteractionMetricSingleton.set_state("boss_1", 1)
#
#var coins = InteractionMetricSingleton.get_state("coins")
#var boss = InteractionMetricSingleton.get_state("boss_1")
#
#InteractionMetricSingleton.save()
