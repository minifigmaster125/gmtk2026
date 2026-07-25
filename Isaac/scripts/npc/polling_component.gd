extends Node
class_name PollingComponent

@export var interval := 4.0

var timer := 0.0

func update(delta) -> bool:
	timer -= delta
	if timer <= 0:
		timer = interval
		return true
	return false

func prompt():
	timer = 0

func reset():
	timer = interval

func set_delay(d):
	interval = d
	
#if polling.update(delta):
	#check_path()
	
#polling.prompt()
