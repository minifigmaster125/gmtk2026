extends Node
class_name ShuffleComponent

var left_first := true

func choose_step(current: Vector2i, goal: Vector2i) -> Vector2i:

	var dx = goal.x - current.x
	var dy = goal.y - current.y

	var horiz = Vector2i(sign(dx),0)
	var vert = Vector2i(0,sign(dy))

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
