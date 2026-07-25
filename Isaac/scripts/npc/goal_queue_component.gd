extends Node
class_name GoalQueueComponent

var queue : Array[Node2D] = []
@export var target_nodes : Array[Node2D] = []

func _ready():
	queue_targets()

func queue_targets():
	for target_node in target_nodes:
		enqueue(target_node)

func enqueue(goal: Node2D):
	queue.push_back(goal)

func push_front(goal: Node2D):
	queue.push_front(goal)

func clear_queue():
	queue.clear()

func pop_first() -> Vector2:
	if queue.is_empty() or queue.pop_front() == null:
		return Vector2.INF
	return queue.pop_front().global_position

func pop_last() -> Vector2:
	if queue.is_empty() or queue.pop_back() == null:
		return Vector2.INF
	return queue.pop_back().global_position

func peek() -> Vector2:
	if queue.is_empty() or queue.front() == null:
		return Vector2.INF
	return queue.front().global_position

func has_goal():
	return !queue.is_empty()
