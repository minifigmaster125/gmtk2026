extends Label

const NORMAL_COLOR = Color("fcff00")
const FAST_COLOR = Color("f92900")
const SLOW_COLOR = Color("246ded")
const INCREASE_COLOR = Color("06ad00")

func mood_color(mood: float) -> Color:
	if mood < 0:
		return INCREASE_COLOR
	elif mood < .9 :
		return SLOW_COLOR
	elif mood > 1.1:
		return FAST_COLOR
	return NORMAL_COLOR

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var anxiety := int(GameManager.get_anxiety())
	var modifier = ""
	if anxiety < 0:
		anxiety = -anxiety
		modifier = "!-"
		add_theme_color_override("font_color", Color("ff00ffff"))
	else:
		add_theme_color_override("font_color", mood_color(GameManager.get_mood()))
	@warning_ignore("integer_division")
	var minutes := anxiety / 600
	@warning_ignore("integer_division")
	var seconds := (anxiety % 600) / 10
	var ms := anxiety % 10
	
	self.text = "🫀 " + modifier + str(minutes) + (":%02d" % seconds) + "." + str(ms)
