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

func pop_first() -> Node2D:
	if queue.is_empty():
		return null
	return queue.pop_front()

func pop_last() -> Node2D:
	if queue.is_empty():
		return null
	return queue.pop_back()

func peek() -> Node2D:
	if queue.is_empty():
		return null
	return queue.front()

func has_goal():
	return !queue.is_empty()
