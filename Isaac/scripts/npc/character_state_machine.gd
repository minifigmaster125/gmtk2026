extends Node
class_name CharacterStateMachine

enum State {
	IDLE,
	MOVING
}

@export var goals: GoalQueueComponent
@export var pathfinding: PathfinderComponent

@export var arrival_distance := 4.0

@export var target_reset_interval := 4.0
@export var idle_interval := .5
@export var moving_interval := 3
@export var dodging_interval := 2

var time_since = {"target_reset":0.0, "idle":0.0, "moving":0.0, "directional_change":0.0}

var state := State.IDLE
var current_goal := Vector2.INF

func _ready():
	pathfinding.target = goals.peek()
	pathfinding.pathfinding_finished.connect(_on_pathfinding_finished)

func _on_pathfinding_finished():
	_set_idle_state()

func _process(delta):
	match state:
		State.IDLE:
			time_since["idle"] += delta
			if time_since["idle"] > idle_interval:
				_set_moving_state()

		State.MOVING:
			time_since["moving"] += delta

func _set_idle_state():
	time_since["moving"] = 0.0
	state = State.IDLE

func _set_moving_state():
	time_since["idle"] = 0.0
	state = State.MOVING
	goals.enqueue(goals.pop_first())
	pathfinding.update_target(goals.peek())
