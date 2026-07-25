extends Node
class_name ShuffleComponent

var left_first := true

func direction_on_collision(direction: Vector2) -> Vector2:
	var sign = 1 if left_first else -1
	return Vector2(direction.y, direction.x)

func choose_step(current: Vector2i, goal: Vector2i) -> Vector2:

	var dx = goal.x - current.x
	var dy = goal.y - current.y
	print("dx: " + var_to_str(dx))
	print("dy: " + var_to_str(dy))
	var horiz = Vector2(sign(dx),0)
	var vert = Vector2(0,sign(dy))

	if horiz.length() == 0:
		horiz = Vector2(1, 0)

	if vert.length() == 0:
		vert = Vector2(0, 1)

	var prefer_horizontal = abs(dx) >= abs(dy)

	if left_first:
		if prefer_horizontal:
			return horiz
		return vert

	if prefer_horizontal:
		return vert
	return horiz

func toggle():
	left_first = !left_first
	
#shuffle.toggle()
