extends AudioStreamPlayer

# Attach this as a child of a Button (or any BaseButton).
# Assign an AudioStream in the Inspector.

func _ready():
	var button := get_parent() as BaseButton

	if button == null:
		push_error("HoverSound must be a child of a BaseButton.")
		return

	button.mouse_entered.connect(_on_mouse_entered)

func _on_mouse_entered():
	play()
