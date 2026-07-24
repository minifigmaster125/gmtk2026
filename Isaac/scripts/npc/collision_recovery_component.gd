extends Node
class_name CollisionRecoveryComponent

@export var reset_delay := 0.25

var collision_dir := Vector2.ZERO
var timer := 0.0

func record_collision(direction: Vector2):
	collision_dir = direction
	timer = reset_delay

func update(delta):
	if timer > 0:
		timer -= delta
		if timer <= 0:
			collision_dir = Vector2.ZERO

func recently_collided() -> bool:
	return collision_dir != Vector2.ZERO
	
#collision.update(delta)
#
#if body.get_slide_collision_count() > 0:
	#collision.record_collision(desired_dir)
