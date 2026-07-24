extends Node

@export var rotation_speed: float = 90.0 # Degrees per second

var _parent: Node2D

func _ready():
	_parent = get_parent() as Node2D
	if _parent == null:
		push_error("RotationComponent must be a child of a Node2D.")

func _process(delta):
	if _parent == null:
		return

	_parent.rotation_degrees += rotation_speed * delta
