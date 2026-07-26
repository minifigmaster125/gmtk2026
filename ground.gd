extends TileMapLayer

@export var other_layers : Array[TileMapLayer]


func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	for layer in other_layers:
		var used = layer.get_used_cells_by_id(0)
		if coords in layer.get_used_cells_by_id(0): 
			return true

	return false


func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	for layer in other_layers:
		var l = layer as TileMapLayer
		if coords in l.get_used_cells_by_id(0):
			tile_data.set_navigation_polygon(0, null)
