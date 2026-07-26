extends Node
class_name PathfinderComponent

@export var navigation_agent_2d: NavigationAgent2D

@export var movement_speed = 100.

var target : Node2D
var pause_pathfinding = false
var agent = CharacterBody2D

signal pathfinding_finished()

# must be called in _physics_process
func _ready() -> void:
	agent = get_parent()
	navigation_agent_2d.velocity_computed.connect(Callable(_on_velocity_computed))

func _physics_process(delta: float) -> void:
	if not pause_pathfinding:
		navigation_agent_2d.target_position = target.global_position
		var current_agent_position = agent.global_position
		var next_path_position = navigation_agent_2d.get_next_path_position()
		var new_velocity = current_agent_position.direction_to(next_path_position) * movement_speed

		if navigation_agent_2d.is_navigation_finished():
			_finish_pathfinding()
			return

		if navigation_agent_2d.avoidance_enabled:
			navigation_agent_2d.set_velocity(new_velocity)
		else:
			agent.velocity = new_velocity
		agent.move_and_slide()

func _finish_pathfinding():
	pause_pathfinding = true
	pathfinding_finished.emit()

func update_target(new_target: Node2D):
	target = new_target
	pause_pathfinding = false

func _on_velocity_computed(safe_velocity: Vector2):
	agent.velocity = safe_velocity
