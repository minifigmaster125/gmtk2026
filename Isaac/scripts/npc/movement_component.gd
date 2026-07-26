extends Node
class_name MovementComponent

@export var speed := 80.0
@export var acceleration := 600.0
@export var friction := 800.0

var body : CharacterBody2D
var desired_velocity := Vector2.ZERO

func _ready():
	body = get_parent()

func _physics_process(delta):
	if body == null:
		return

	if desired_velocity.length_squared() > 0.01:
		body.velocity = body.velocity.move_toward(desired_velocity, acceleration * delta)
	else:
		body.velocity = body.velocity.move_toward(Vector2.ZERO, friction * delta)

	body.move_and_slide()

func move_direction(dir: Vector2):
	if dir.length_squared() <= 0.01:
		desired_velocity = Vector2.ZERO
		return

	desired_velocity = dir.normalized() * speed

func move_to(goal: Vector2):
	move_direction(goal - body.global_position)

func stop():
	desired_velocity = Vector2.ZERO
	
#movement.move_to(next_goal)
#movement.stop()
