extends CharacterBody2D

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D
@export var target : Node2D

@export var movement_speed = 100.

func _physics_process(delta: float) -> void:
	navigation_agent_2d.target_position = target.global_position

	var current_agent_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	var new_velocity = current_agent_position.direction_to(next_path_position) * movement_speed

	if navigation_agent_2d.is_navigation_finished():
		return

	_on_navigation_agent_2d_velocity_computed(new_velocity)
	move_and_slide()


func _on_navigation_agent_2d_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
