extends CharacterBody2D

@export_range(0, 20) var interest_rate := 20
@export var character_name := "Count"
@export var interest = 0

@onready var interest_area = $InterestArea2D as Area2D
@onready var interest_progress := $ProgressBar as ProgressBar

var dialog_scene = preload("res://components/conversation/dialog_control.tscn")
var dialog_instance = null

var _interested := false

func _ready() -> void:
	interest_area.body_entered.connect(_on_body_entered)
	interest_area.body_exited.connect(_on_body_exited)
	if InteractionMetricSingleton.has_state(character_name):
		interest_progress.value = InteractionMetricSingleton.get_state(character_name)

func _process(delta: float):
	if _interested:
		interest_progress.value += interest_rate * delta
		InteractionMetricSingleton.set_state(character_name, interest_progress.value)


func _on_body_entered(body: Node2D):
	if body is Player:
		_interested = true
		dialog_instance = dialog_scene.instantiate()
		get_tree().root.add_child(dialog_instance)
		dialog_instance.recieve_conversing_event(true, "Count_A")

func _on_body_exited(body: Node2D):
	if body is Player:
		_interested = false
		if dialog_instance != null:
			dialog_instance._exit_pressed()
