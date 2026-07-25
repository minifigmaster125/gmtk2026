extends CharacterBody2D
class_name Player

const _tile_size: Vector2 = Vector2(32,32)
var _sprite_node_pos_tween: Tween

@export var _mood_field: MoodField

@onready var _up =  $up as RayCast2D
@onready var _down =  $down as RayCast2D
@onready var _left =  $left as RayCast2D
@onready var _right =  $right as RayCast2D
@onready var _sprite := $AnimatedSprite2D as AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	if self._mood_field != null:
		self._mood_field.update_mood(transform.get_origin())
	if !_sprite_node_pos_tween or !_sprite_node_pos_tween.is_running():
		_sprite.stop()
		if (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_up_")) and !_up.is_colliding():
			_move(Vector2(0, -1))
			_sprite.play("walk_up")
			return
		if (Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_down_")) and !_down.is_colliding():
			print(global_position)
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
	var sprite_old_pos = _sprite.global_position
	global_position += dir * _tile_size
	var sprite_new_pos = _sprite.global_position
	_sprite.global_position = sprite_old_pos

	if _sprite_node_pos_tween:
		_sprite_node_pos_tween.kill()
	_sprite_node_pos_tween = create_tween()
	_sprite_node_pos_tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	_sprite_node_pos_tween.tween_property(_sprite, "global_position", sprite_new_pos, 0.25)
