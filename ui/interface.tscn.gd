extends Control
class_name Interface

@export var level_timer : Timer

@onready var level_timer_label := %LevelTimerLabel as RichTextLabel

func _ready():
	assert(level_timer != null)

func _process(_delta: float) -> void:
	# print(level_timer.time_left)
	level_timer_label.text = format_time(level_timer.time_left)

func format_time(seconds: float) -> String:
	# print(seconds)
	var mins: int = int(seconds) / 60
	var secs: int = int(seconds) % 60
	var msec: int = int((seconds - int(seconds)) * 100)

	# Returns format MM:SS:MS (e.g., 02:15:48)
	return "%02d:%02d" % [mins, secs]
