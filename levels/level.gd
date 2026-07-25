extends Node2D
class_name Level

@onready var level_timer := %LevelTimer as Timer

func _ready():
	level_timer.start()

