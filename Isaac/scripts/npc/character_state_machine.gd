extends Node
class_name CharacterStateMachine

enum State {
	IDLE,
	MOVING
}

@export var direction: DirectionComponent
@export var movement: MovementComponent
@export var goals: GoalQueueComponent
@export var collision: CollisionRecoveryComponent
@export var shuffle: ShuffleComponent

@export var arrival_distance := 4.0

@export var target_reset_interval := 4.0
@export var idle_interval := 5.0
@export var move_interval := 5.0
@export var dodging_interval := 4

var time_since = {"target_reset":0.0, "idle":0.0, "move":0.0, "directional_change":0.0}

var state := State.IDLE
var current_goal := Vector2.INF

var dodging = false #reduces jitter on collision

func _process(delta):
	_update_time_since(delta)
	collision.update(delta)
	
	if time_since["target_reset"] > target_reset_interval:
		current_goal = goals.peek()
		time_since["target_reset"] = 0.0

	print("target global position: " + var_to_str(goals.peek()))


	match state:

		State.IDLE:
			_idle_state()

		State.MOVING:
			_moving_state(delta)

func _update_time_since(delta):
	for key in time_since:
		time_since[key] += delta


func _idle_state():
	print("IDLE")

	# if goals.has_goal():
	if time_since["moving"] > move_interval:
		current_goal = goals.peek()
		state = State.MOVING
		time_since["moving"] = 0.0


func _moving_state(delta : float):
	print("MOVING")
	# if current_goal == Vector2.INF:
	if time_since["idle"] > idle_interval:
		state = State.IDLE
		time_since["idle"] = 0.0
		return
	print("hasgoal: " + var_to_str(goals.has_goal()))

	var body := get_parent() as CharacterBody2D

	# Arrived?
	if body.global_position.distance_to(current_goal) <= arrival_distance:
		goals.pop_first()
	
		if goals.has_goal():
			current_goal = goals.peek()
		else:
			goals.queue_targets()
			# current_goal = Vector2.INF
			movement.stop()
			state = State.IDLE
		return

	# Determine desired movement
	var current_cell := Vector2i(round(body.global_position.x), round(body.global_position.y))
	var goal_cell := Vector2i(round(current_goal.x), round(current_goal.y))

	var step := direction.direction_vector()
	if time_since["directional_change"] > dodging_interval:
		time_since["directional_change"] = 0.0
		dodging = !dodging

	if body.get_slide_collision_count() > 0 and dodging:
		step = shuffle.direction_on_collision(step)
	elif current_cell != goal_cell:
		step = shuffle.choose_step(current_cell, goal_cell)
		
	print("name: " + get_parent().name)
	print("step: " + var_to_str(step))
	print("dodging: " + var_to_str(dodging))
	print("has_goal " + var_to_str(goals.has_goal()))

	# var step := direction.direction_vector()
	# if body.get_slide_collision_count() > 0:
	# 		step = shuffle.direction_on_collision(direction.direction_vector())

	# if time_since["directional_change"] > directional_change_interval:
	# 	time_since["directional_change"] = 0.0
	# 	if body.get_slide_collision_count() > 0:
	# 		step = shuffle.direction_on_collision(direction.direction_vector())
	# 	else:
	# 		step = shuffle.choose_step(current_cell, goal_cell)
		

	direction.set_from_vector(step)
	movement.move_direction(step)

	# Collision recovery
	# print("slide_collision_count: " + var_to_str(body.get_slide_collision_count()))
	if body.get_slide_collision_count() > 0:
		collision.record_collision(step)
	shuffle.toggle()

		
		
#goals.enqueue(Vector2(320, 96))
#goals.enqueue(Vector2(320, 224))
#goals.enqueue(Vector2(96, 224))
