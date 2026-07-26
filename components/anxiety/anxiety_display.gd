extends Label

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var anxiety := int(GameManager.get_anxiety())
	var modifier = ""
	if anxiety < 0:
		anxiety = 0
		#modifier = "!-"
		add_theme_color_override("font_color", Color("ff00ffff"))
	else:
		add_theme_color_override("font_color", MoodUtil.mood_color(GameManager.get_mood()))
	@warning_ignore("integer_division")
	var minutes := anxiety / 600
	@warning_ignore("integer_division")
	var seconds := (anxiety % 600) / 10
	var ms := anxiety % 10
	
	self.text = "🫀 " + modifier + str(minutes) + (":%02d" % seconds) + "." + str(ms)
