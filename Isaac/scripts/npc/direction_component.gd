extends Node
class_name DirectionComponent

enum Facing {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

@export var facing := Facing.DOWN

func direction_vector() -> Vector2i:
	match facing:
		Facing.UP:
			return Vector2i.UP
		Facing.DOWN:
			return Vector2i.DOWN
		Facing.LEFT:
			return Vector2i.LEFT
		Facing.RIGHT:
			return Vector2i.RIGHT
	return Vector2i.ZERO

func set_from_vector(v: Vector2):
	if abs(v.x) > abs(v.y):
		facing = Facing.RIGHT if v.x > 0 else Facing.LEFT
	else:
		facing = Facing.DOWN if v.y > 0 else Facing.UP

func turn_towards(target: Vector2, origin: Vector2):
	set_from_vector(target - origin)
	
#direction.turn_towards(goal, global_position)
#
#var dir = direction.direction_vector()
