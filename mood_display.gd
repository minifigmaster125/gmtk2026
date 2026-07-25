extends VBoxContainer

var label_scene = preload("res://components/anxiety/mood_breakdown_label.tscn")

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for n in self.get_children():
		self.remove_child(n)
		n.queue_free()
	var breakdown = GameManager.get_mood_breakdown()
	for b in breakdown:
		var lbl = label_scene.instantiate()
		lbl.text = b.name
		lbl.add_theme_color_override("font_color", MoodUtil.mood_color(b.value))
		self.add_child(lbl)
		
