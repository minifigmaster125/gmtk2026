class_name MoodField extends Node2D

@export var debug_display := false

const CELL_SIZE = 32

var mood_map := [[1.0]]

func build_mood_map():
	self.mood_map =	[
		[0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0],
		[0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0],
		[1.0, 1.0, 1.0, .75, 1.0, 1.0, 1.0],
		[-1., -1., -1., .75, 1.0, 1.0, 1.0],
	]

func _ready() -> void:
	build_mood_map()
	var mood_nodes = get_tree().get_nodes_in_group("mood_affecting")
	for node in mood_nodes:
		var tf = node.get("transform")
		var mood_config = node.get("mood_config")
		if mood_config == "count" and tf:
			var xy = pos_to_xy(tf.origin)
			mood_map[xy.y-1][xy.x-1] = 1.5
			mood_map[xy.y-1][xy.x] = 2.0
			mood_map[xy.y-1][xy.x+1] = 1.5
			mood_map[xy.y][xy.x-1] = 2.0
			mood_map[xy.y][xy.x] = 2.0
			mood_map[xy.y][xy.x+1] = 2.0
			mood_map[xy.y+1][xy.x-1] = 1.5
			mood_map[xy.y+1][xy.x] = 2.0
			mood_map[xy.y+1][xy.x+1] = 1.5
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_mood(player_position: Vector2):
	var pos = pos_to_xy(player_position)
	GameManager.set_mood(get_mood_at(pos))

func pos_to_xy(pos: Vector2) -> Vector2i:
	@warning_ignore("narrowing_conversion")
	return Vector2i((pos.x - 8.0)/CELL_SIZE, (pos.y - 8.0)/CELL_SIZE)

func get_mood_at(pos: Vector2i) -> float:
	if pos.y < 0 or pos.y >= mood_map.size():
		return 1.0
	if pos.x < 0 or pos.x >= mood_map[pos.y].size():
		return 1.0
	return mood_map[pos.y][pos.x]

## DEBUG DISPLAY FUNCTIONS ##

var grid_size := Vector2i(8, 5)

# queue_redraw() to refresh
func _draw():
	if not debug_display:
		return
	for y in grid_size.y:
		for x in grid_size.x:
			var t = adjust_value(get_mood_at(Vector2i(x, y)))
			var color = Color.from_hsv(
				lerp(0.33, 0.0, t), # green -> red
				1.0,
				1.0,
				.3
			)
			draw_rect(
				Rect2(x * CELL_SIZE, y * CELL_SIZE, CELL_SIZE, CELL_SIZE),
				color
			)

## Adjust range from -1 to 2 to be 0 to 1
func adjust_value(v: float) -> float:
	return (v + 1)/3
