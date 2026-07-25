extends Resource
class_name MoodConfig

@export var type: String

static func create(
	_type: String,
) -> MoodConfig:
	var n: MoodConfig = MoodConfig.new()
	n.type = _type
	return n
	
