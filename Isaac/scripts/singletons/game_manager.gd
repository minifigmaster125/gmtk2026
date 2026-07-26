extends Node

const FILE := "user://save.dat"
var states:Dictionary = {}
var time:float = 360.0
var anxiety:float = 3000.0

var mood:float = 1.0

var persistent_moods = []

var mood_breakdown = []

var conversation_stages:Dictionary = {}
var target_name = "CountA"
var current_level : Level

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
	
func get_mood_breakdown():
	return persistent_moods + mood_breakdown
	
func set_mood_breakdown(breakdown):
	self.mood_breakdown = breakdown
	
	self.mood = 0
	for causes in get_mood_breakdown():
		self.mood += causes.value
	
func set_mood(amt: float) -> float:
	self.mood = amt
	return self.mood

func has_interaction_metric(key:String) -> bool:
	return states.has(key)

func get_interaction_metric(key:String) -> int:
	return states.get(key, 0)

func set_interaction_metric(key:String, value:int):
	states[key] = value
	
func set_conversation_stage(key:String, value:int):
	self.conversation_stages[key] = value
	
func get_conversation_stage(key:String) -> int:
	return self.conversation_stages.get(key, 1)

func conversation_completed(convo:String):
	var name = convo.substr(0, convo.length()-1)
	var stage = convo.substr(convo.length()-1, convo.length()).to_int()
	self.set_conversation_stage(name, stage+1)
	print(has_interaction_metric(name))
	if has_interaction_metric(name):
		print("RESET")
		set_interaction_metric(name, 0)

	match current_level.level_num:
		3:
			if name == "Count_A" and stage == 1:
				current_level.end_level()
		4:
			if name == "Count_A" and stage == 3:
				current_level.end_level()

func save():
	FileAccess.open(FILE, FileAccess.WRITE).store_var(states)

	
#example usage:
#GameManager.<wtv function>
