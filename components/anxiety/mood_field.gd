class_name MoodField extends Node2D

@export var mood_map_layer : TileMapLayer

const CELL_SIZE = 32

var dynamic_mood_map: Dictionary

func build_dynamic_mood_map():
	dynamic_mood_map.clear()
	var mood_nodes = get_tree().get_nodes_in_group("mood_affecting")
	for node in mood_nodes:
		var tf = node.get("transform")
		var mood_config: MoodConfig = node.get("mood_config")
		if mood_config.type == "count" and tf:
			var xy = pos_to_xy(tf.origin)
			dynamic_mood_map.set(xy, 2.0)
			dynamic_mood_map.set(xy + Vector2i(0, 1), 2.0)
			dynamic_mood_map.set(xy + Vector2i(0, -1), 2.0)
			dynamic_mood_map.set(xy + Vector2i(1, 0), 2.0)
			dynamic_mood_map.set(xy + Vector2i(-1, 0), 2.0)
			dynamic_mood_map.set(xy + Vector2i(1, 1), 1.0)
			dynamic_mood_map.set(xy + Vector2i(1, -1), 1.0)
			dynamic_mood_map.set(xy + Vector2i(-1, 1), 1.0)
			dynamic_mood_map.set(xy + Vector2i(-1, -1), 1.0)
			
func _ready() -> void:
	build_dynamic_mood_map()

func _process(delta: float) -> void:
	build_dynamic_mood_map()
	queue_redraw()
	
func update_mood(player_position: Vector2):
	var pos = pos_to_xy(player_position)
	GameManager.set_mood(get_mood_at(pos))
	GameManager.set_mood_breakdown(get_mood_breakdown_at(pos))

func pos_to_xy(pos: Vector2) -> Vector2i:
	@warning_ignore("narrowing_conversion")
	return Vector2i(pos.x/CELL_SIZE, pos.y/CELL_SIZE)

func tile_id_to_mood(id: int) -> float:
	match id:
		0:
			return -1.0
		1:
			return .5
		2:
			return 1.0
		3:
			return 2.0
		_:
			return 1.0

func get_mood_breakdown_at(pos: Vector2i) -> Variant:
	var base_value := 1.0
	var result = []
	if mood_map_layer:
		base_value = tile_id_to_mood(mood_map_layer.get_cell_atlas_coords(pos).x)
		result.append({name="Environment", value=base_value})
	if pos in dynamic_mood_map:
		result.append({name="Count Nearby", value=dynamic_mood_map.get(pos)})
	return result

func get_mood_at(pos: Vector2i) -> float:
	var base_value := 1.0
	if mood_map_layer:
		base_value = tile_id_to_mood(mood_map_layer.get_cell_atlas_coords(pos).x)
	if pos in dynamic_mood_map:
		return max(dynamic_mood_map.get(pos), base_value)
	return base_value

## DEBUG DISPLAY FUNCTIONS ##

@export var grid_size := Vector2i(20, 20)

# queue_redraw() to refresh
func _draw():
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
