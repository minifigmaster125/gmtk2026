extends Node
class_name MovementComponent

@export var speed := 80.0

var body : CharacterBody2D

func _ready():
	body = get_parent()

func move_direction(dir: Vector2):
	body.velocity = dir.normalized() * speed
	body.move_and_slide()

func move_to(goal: Vector2):
	move_direction(goal - body.global_position)

func stop():
	body.velocity = Vector2.ZERO
	
#movement.move_to(next_goal)
#movement.stop()
