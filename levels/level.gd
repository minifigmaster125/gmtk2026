extends Node2D
class_name Level

@export var player : Player
@export var next_scene: PackedScene

@onready var level_timer := %LevelTimer as Timer
@onready var cover_rect := %CoverRect as ColorRect

@export var level_num : int

func _ready():
	assert(player != null)
	assert(next_scene != null)
	# player.process_mode = Node.PROCESS_MODE_DISABLED

	start_level()
	# player.process_mode = Node.PROCESS_MODE_INHERIT

	GameManager.current_level = self
	level_timer.timeout.connect(_on_level_timer_timeout)
	level_timer.start()

func _process(delta: float) -> void:
	var anxiety = GameManager.get_anxiety()
	if anxiety <= 0:
		end_level()

func _on_level_timer_timeout():
	end_level()
	
func start_level() -> void:
	# stop input
	# fade to black
	# save relevant stats
	# transition to new scene
	GameManager.anxiety = 3000
	var tween: Tween = create_tween()
	cover_rect.visible = true
	tween.tween_property(cover_rect, "modulate:a", 0, 5)
	await tween.finished
	cover_rect.visible = false

const scene_3 = preload("res://levels/level3_ballroom.tscn")
const final_scene = preload("res://levels/final_scene.tscn")

func end_level() -> void:
	# stop input
	# fade to black
	# save relevant stats
	# transition to new scene
	player.process_mode = Node.PROCESS_MODE_DISABLED

	var tween: Tween = create_tween()
	cover_rect.visible = true
	tween.tween_property(cover_rect, "modulate:a", 1., 1.)
	await tween.finished
	GameManager.set_interaction_metric("Count_A", 0)
	GameManager.set_interaction_metric("Count_B", 0)
	GameManager.set_interaction_metric("Count_C", 0)
	GameManager.persistent_moods = []
	# get_tree().change_scene_to_packed(next_scene)
	
	if level_num == 3:
		get_tree().change_scene_to_packed(scene_3)

	if level_num == 4:
		get_tree().change_scene_to_packed(final_scene)
