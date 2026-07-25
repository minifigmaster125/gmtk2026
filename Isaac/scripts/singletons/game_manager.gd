extends Node

const FILE := "user://save.dat"
var states:Dictionary = {}
var time:float = 360.0
var anxiety:float = 800.0

var mood:float = 1.0


func _ready():
	if FileAccess.file_exists(FILE):
		states = FileAccess.open(FILE, FileAccess.READ).get_var()

func _process(delta: float):
	time -= delta
	self.tick_anxiety(-10 * delta)

func get_time() -> float:
	return time

# func set_time(_time:float):
# 	time = _time

func get_anxiety() -> float:
	return anxiety
	
func tick_anxiety(amt: float) -> float:
	self.anxiety = self.anxiety + amt * mood
	return self.anxiety
	
func get_mood():
	return mood
	
func set_mood(amt: float) -> float:
	self.mood = amt
	return self.mood

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
