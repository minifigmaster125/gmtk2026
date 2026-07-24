extends Node

@export var amplitude_x: float = 20.0
@export var amplitude_y: float = 20.0
@export var speed_x: float = 2.0
@export var speed_y: float = 2.0

var _parent: Node2D
var _start_x: float
var _start_y: float
var _time := 0.0

func _ready():
	_parent = get_parent() as Node2D
	if _parent == null:
		push_error("BobbingComponent must be a child of a Node2D.")
		return

	_start_x = _parent.position.x
	_start_y = _parent.position.y

func _process(delta):
	if _parent == null:
		return

	_time += delta
	_parent.position.x = _start_x + sin(_time * TAU * speed_x) * amplitude_x
	_parent.position.y = _start_y + sin(_time * TAU * speed_y) * amplitude_y
