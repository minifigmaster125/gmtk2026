extends CharacterBody2D

const _tile_size: Vector2 = Vector2(16,16)
var _sprite_node_pos_tween: Tween

@onready var _up =  $up as RayCast2D
@onready var _down =  $down as RayCast2D
@onready var _left =  $left as RayCast2D
@onready var _right =  $right as RayCast2D

func _physics_process(_delta: float) -> void:
	if !_sprite_node_pos_tween or !_sprite_node_pos_tween.is_running():
		if Input.is_action_pressed("ui_up") and !_up.is_colliding():
			_move(Vector2(0, -1))
		if Input.is_action_pressed("ui_down") and !_down.is_colliding():
			_move(Vector2(0, 1))
		if Input.is_action_pressed("ui_left") and !_left.is_colliding():
			_move(Vector2(-1, 0))
		if Input.is_action_pressed("ui_right") and !_right.is_colliding():
			_move(Vector2(1, 0))

func _move(dir: Vector2):
	global_position += dir * _tile_size
	$Sprite2D.global_position -= dir * _tile_size

	if _sprite_node_pos_tween:
		_sprite_node_pos_tween.kill()
	_sprite_node_pos_tween = create_tween()
	_sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	_sprite_node_pos_tween.tween_property($Sprite2D, "global_position", global_position, 0.2)