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
@export var polling: PollingComponent
@export var focus: FocusBiasComponent

@export var arrival_distance := 4.0

var state := State.IDLE
var current_goal := Vector2.INF


func _process(delta):
	collision.update(delta)

	match state:

		State.IDLE:
			_idle_state()

		State.MOVING:
			_moving_state()


func _idle_state():

	if polling.update(0):
		pass # Placeholder for expensive AI/pathfinding updates

	if goals.has_goal():
		current_goal = goals.peek()
		state = State.MOVING


func _moving_state():

	if current_goal == Vector2.INF:
		state = State.IDLE
		return

	# Apply optional focus bias
	if focus:
		current_goal = focus.choose(current_goal)

	var body := get_parent() as CharacterBody2D

	# Arrived?
	if body.global_position.distance_to(current_goal) <= arrival_distance:
		goals.pop_first()

		if goals.has_goal():
			current_goal = goals.peek()
		else:
			current_goal = Vector2.INF
			movement.stop()
			state = State.IDLE
		return

	# Determine desired movement
	var current_cell := Vector2i(round(body.global_position.x), round(body.global_position.y))
	var goal_cell := Vector2i(round(current_goal.x), round(current_goal.y))

	var step := shuffle.choose_step(current_cell, goal_cell)

	direction.set_from_vector(step)
	movement.move_direction(step)

	# Collision recovery
	if body.get_slide_collision_count() > 0:
		collision.record_collision(step)
		shuffle.toggle()
		
#goals.enqueue(Vector2(320, 96))
#goals.enqueue(Vector2(320, 224))
#goals.enqueue(Vector2(96, 224))
