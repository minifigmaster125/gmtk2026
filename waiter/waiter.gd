extends CharacterBody2D

@export_range(0, 20) var interest_rate := 20
@export var character_name := "Count"
@export var interest = 0
@export var portrait : Texture2D

@onready var interest_area = $InterestArea2D as Area2D

@export var mood_config: MoodConfig

var dialog_scene = preload("res://components/conversation/dialog_control.tscn")
var dialog_instance = null

var _interested := false

func _ready() -> void:
	pass

func _process(delta: float):
	pass

func _on_body_entered(body: Node2D):
	if body is Player:
		pass #faux paus and idle state

func _on_body_exited(body: Node2D):
	if body is Player:
		pass #faux paus and move state
