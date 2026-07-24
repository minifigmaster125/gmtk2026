extends Node
class_name GoalQueueComponent

var queue : Array[Vector2] = []

func enqueue(goal: Vector2):
	queue.push_back(goal)

func push_front(goal: Vector2):
	queue.push_front(goal)

func clear_queue():
	queue.clear()

func pop_first() -> Vector2:
	if queue.is_empty():
		return Vector2.INF
	return queue.pop_front()

func pop_last() -> Vector2:
	if queue.is_empty():
		return Vector2.INF
	return queue.pop_back()

func peek() -> Vector2:
	if queue.is_empty():
		return Vector2.INF
	return queue.front()

func has_goal():
	return !queue.is_empty()
