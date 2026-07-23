extends CharacterBody2D
class_name Player

const _tile_size: Vector2 = Vector2(16,16)
var _sprite_node_pos_tween: Tween

@onready var _up =  $up as RayCast2D
@onready var _down =  $down as RayCast2D
@onready var _left =  $left as RayCast2D
@onready var _right =  $right as RayCast2D

func _physics_process(_delta: float) -> void:
	if !_sprite_node_pos_tween or !_sprite_node_pos_tween.is_running():
		if (Input.is_action_pressed("ui_up") or Input.is_action_just_pressed("ui_up_")) and !_up.is_colliding():
			_move(Vector2(0, -1))
			return
		if (Input.is_action_pressed("ui_down") or Input.is_action_just_pressed("ui_down_")) and !_down.is_colliding():
			_move(Vector2(0, 1))
			return
		if (Input.is_action_pressed("ui_left") or Input.is_action_just_pressed("ui_left_")) and !_left.is_colliding():
			_move(Vector2(-1, 0))
			return
		if (Input.is_action_pressed("ui_right") or Input.is_action_just_pressed("ui_right_")) and !_right.is_colliding():
			_move(Vector2(1, 0))
			return

func _move(dir: Vector2):
	global_position += dir * _tile_size
	$Sprite2D.global_position -= dir * _tile_size

	if _sprite_node_pos_tween:
		_sprite_node_pos_tween.kill()
	_sprite_node_pos_tween = create_tween()
	_sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	_sprite_node_pos_tween.tween_property($Sprite2D, "global_position", global_position, 0.25)
