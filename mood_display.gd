extends VBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	for n in self.get_children():
		self.remove_child(n)
		n.queue_free()
	var breakdown = GameManager.get_mood_breakdown()
	for b in breakdown:
		var lbl = Label.new()
		lbl.text = b.name
		lbl.add_theme_color_override("font_color", MoodUtil.mood_color(b.value))
		lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		self.add_child(lbl)
		
		
