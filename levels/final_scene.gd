extends Node2D

@onready var win_ui = $CanvasLayer/YouWin
@onready var lose_ui = $CanvasLayer/YouLose

func _ready():
	if GameManager.conversation_stages.has("Count_A") and GameManager.conversation_stages["Count_A"] >= 3:
		win_ui.show()
		lose_ui.hide()
	else:
		win_ui.hide()
		lose_ui.show()
