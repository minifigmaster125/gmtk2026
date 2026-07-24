extends Sprite2D
class_name SpriteDirectionalAnimationComponent

@export var direction: DirectionComponent

@export var up: Texture2D
@export var down: Texture2D
@export var left: Texture2D
@export var right: Texture2D

var _last_facing := -1

func _process(_delta):
	if direction.facing == _last_facing:
		return

	_last_facing = direction.facing

	match direction.facing:
		DirectionComponent.Facing.UP:
			texture = up
		DirectionComponent.Facing.DOWN:
			texture = down
		DirectionComponent.Facing.LEFT:
			texture = left
		DirectionComponent.Facing.RIGHT:
			texture = right
