extends CharacterBody2D

@export_range(0, 20) var interest_rate := 20

@onready var interest_area = $InterestArea2D as Area2D
@onready var interest_progress := $ProgressBar as ProgressBar

var _interested := false

func _ready() -> void:
	interest_area.body_entered.connect(_on_body_entered)
	interest_area.body_exited.connect(_on_body_exited)

func _process(delta: float):
	if _interested:
		interest_progress.value += interest_rate * delta

func _on_body_entered(body: Node2D):
	if body is Player:
		_interested = true
func _on_body_exited(body: Node2D):
	if body is Player:
		_interested = false
