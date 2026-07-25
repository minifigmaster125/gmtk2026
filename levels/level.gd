extends Node2D
class_name Level

@export var player : Player
@export var next_scene: PackedScene

@onready var level_timer := %LevelTimer as Timer
@onready var cover_rect := %CoverRect as ColorRect

func _ready():
	assert(player != null)
	assert(next_scene != null)
	level_timer.timeout.connect(_on_level_timer_timeout)
	level_timer.start()

func _process(delta: float) -> void:
	var anxiety = GameManager.get_anxiety()
	if anxiety <= 0:
		_end_level()

func _on_level_timer_timeout():
	_end_level()

func _end_level() -> void:
	# stop input
	# fade to black
	# save relevant stats
	# transition to new scene
	player.process_mode = Node.PROCESS_MODE_DISABLED

	var tween: Tween = create_tween()
	cover_rect.visible = true
	tween.tween_property(cover_rect, "modulate:a", 1., 1.)
	await tween.finished

	get_tree().change_scene_to_packed(next_scene)
	


	
