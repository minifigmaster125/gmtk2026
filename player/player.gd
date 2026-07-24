extends CharacterBody2D
class_name Player

const _tile_size: Vector2 = Vector2(32,32)
var _sprite_node_pos_tween: Tween

@onready var _up =  $up as RayCast2D
@onready var _down =  $down as RayCast2D
@onready var _left =  $left as RayCast2D
@onready var _right =  $right as RayCast2D
@onready var _sprite := $AnimatedSprite2D as AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	if !_sprite_node_pos_tween or !_sprite_node_pos_tween.is_running():
		_sprite.stop()
		if (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_up_")) and !_up.is_colliding():
			_move(Vector2(0, -1))
			_sprite.play("walk_up")
			return
		if (Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_down_")) and !_down.is_colliding():
			_move(Vector2(0, 1))
			_sprite.play("walk_down")
			return
		if (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_left_")) and !_left.is_colliding():
			_move(Vector2(-1, 0))
			_sprite.flip_h = true
			_sprite.play("walk_right")
			return
		if (Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_right_")) and !_right.is_colliding():
			_move(Vector2(1, 0))
			_sprite.flip_h = false
			_sprite.play("walk_right")
			return

func _move(dir: Vector2):
	global_position += dir * _tile_size
	_sprite.global_position -= dir * _tile_size

	if _sprite_node_pos_tween:
		_sprite_node_pos_tween.kill()
	_sprite_node_pos_tween = create_tween()
	_sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
<<<<<<< HEAD
	_sprite_node_pos_tween.tween_property(_sprite, "global_position", global_position, 0.25)
=======
	_sprite_node_pos_tween.tween_property($Sprite2D, "global_position", global_position, 0.25)
>>>>>>> 538d68be0ca8194b04437e7516324a965c852a07
