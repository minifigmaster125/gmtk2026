extends Node

const FILE := "user://save.dat"
var states:Dictionary = {}
var time:float = 360.0
var anxiety:int = 0

func _ready():
	if FileAccess.file_exists(FILE):
		states = FileAccess.open(FILE, FileAccess.READ).get_var()

func _process(delta: float):
	time -= delta

func get_time() -> float:
	return time

# func set_time(_time:float):
# 	time = _time

func get_anxiety() -> int:
	return anxiety

func set_anxiety(_anxiety:int):
	return _anxiety

func has_interaction_metric(key:String) -> bool:
	return states.has(key)

func get_interaction_metric(key:String) -> int:
	return states.get(key, 0)

func set_interaction_metric(key:String, value:int):
	states[key] = value

func save():
	FileAccess.open(FILE, FileAccess.WRITE).store_var(states)
	
#example usage:
#GameManager.<wtv function>
