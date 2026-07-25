extends Control

@onready var main_menu: Button = $VBoxContainer/menu

@onready var character: Button = $VBoxContainer/HBoxContainer/character

@onready var convo1: Button = $VBoxContainer/HBoxContainer/convo1
@onready var convo2: Button = $VBoxContainer/HBoxContainer/convo2
@onready var convo3: Button = $VBoxContainer/HBoxContainer/convo3

@onready var script_view: Label = $VBoxContainer/color/scrollbar/margin/script_view

var selected_name: String
var replace_name: String

func _ready() -> void:
	convo1.pressed.connect(show_callback("1"))
	convo2.pressed.connect(show_callback("2"))
	convo3.pressed.connect(show_callback("3"))
	_on_item_selected(0)
	character.item_selected.connect(_on_item_selected)
	
	main_menu.pressed.connect(hide)

func _on_item_selected(index: int):
	replace_name = character.get_item_text(index)
	script_view.text = "Select the conversation script you'd like to view, or return to the main menu."
	if index == 0:
		selected_name = "Count_A"
	elif index == 1:
		selected_name = "Count_B"
	elif index == 2:
		selected_name = "Count_C"
	else:
		selected_name = "Count_A"

func show_callback(idx: String):
	return func (): show_script(selected_name + idx)

func show_script(name: String):
	var file = FileAccess.open("res://dialog/convos/" + name + ".convo", FileAccess.READ)
	var content = file.get_as_text().replace(name, replace_name)
	script_view.text = content

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
