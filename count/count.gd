extends CharacterBody2D

@export_range(0, 20) var interest_rate := 20
@export var character_name := "Count"
@export var interest = 0
@export var portrait : Texture2D

@onready var interest_area = $InterestArea2D as Area2D
@onready var interest_progress := $ProgressBar as ProgressBar

@export var mood_config: MoodConfig
@export var DEBUG_skip_interest: bool = false

@export var conversation_stage_limit: int = 2

var dialog_scene = preload("res://components/conversation/dialog_control.tscn")
var dialog_instance = null

var _interested := false

func _ready() -> void:
	interest_area.body_entered.connect(_on_body_entered)
	interest_area.body_exited.connect(_on_body_exited)
	if GameManager.has_interaction_metric(character_name):
		interest_progress.value = GameManager.get_interaction_metric(character_name)

func _process(delta: float):
	if _interested:
		if dialog_instance == null and (DEBUG_skip_interest or interest_progress.value == interest_progress.max_value):
			dialog_instance = dialog_scene.instantiate()
			get_tree().root.add_child(dialog_instance)
			GameManager.get_conversation_stage(character_name)
			var stage = min(GameManager.get_conversation_stage(character_name), conversation_stage_limit)
			dialog_instance.recieve_conversing_event(true, character_name + str(stage))

		interest_progress.value += interest_rate * delta
		GameManager.set_interaction_metric(character_name, interest_progress.value)

func _on_body_entered(body: Node2D):
	if body is Player:
		_interested = true

func _on_body_exited(body: Node2D):
	if body is Player:
		_interested = false
		if dialog_instance != null:
			dialog_instance._exit_pressed()
