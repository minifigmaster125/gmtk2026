extends Node
class_name FocusBiasComponent

var foci : Array[Vector2] = []

func add_focus(pos: Vector2):
	foci.append(pos)

func clear():
	foci.clear()

func choose(goal: Vector2) -> Vector2:

	if foci.is_empty():
		return goal

	var best = goal
	var best_dist = INF

	for f in foci:
		var d = goal.distance_to(f)
		if d < best_dist:
			best_dist = d
			best = (goal + f) * 0.5

	return best
	
#goal = focus.choose(goal)
