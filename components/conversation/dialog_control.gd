extends Control

@onready var exit: Button = $exit
@onready var logContainer: VBoxContainer = $logScroll/logContainer
@onready var scrollContainer: ScrollContainer = $logScroll

@onready var buttonBox: Container = $options

var conversation = []

var dialog_tree: DialogState
var current_partner = ""

var single_speech_box = preload("dialog_box.tscn")
var dialog_option_button = preload("dialog_option.tscn")
	
func clear_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
	
func _ready() -> void:
	exit.pressed.connect(_exit_pressed)

func execute_tree():
	if dialog_tree == null || dialog_tree.choices.size() == 0 || dialog_tree.speaker == "TERMINUS":
		return

	if dialog_tree.speaker != current_partner:
		for i in range(dialog_tree.short_choices.size()):
			var btn = dialog_option_button.instantiate()
			btn.add_theme_font_size_override("font_size", int(10 * 1))#Util.get_composite_text_scale()))
			btn.pressed.connect(func(): _dialog_selected(i))
			btn.text = dialog_tree.short_choices[i]
			buttonBox.add_child(btn)

		var filler = Control.new()
		filler.size_flags_vertical = Control.SIZE_EXPAND_FILL
		filler.size_flags_stretch_ratio = max(0, 4-dialog_tree.short_choices.size())
		buttonBox.add_child(filler)
		
	else:
		await get_tree().create_timer(1).timeout
		var i = randi_range(0, dialog_tree.choices.size() - 1)
		add_speech(dialog_tree.speaker, dialog_tree.choices[i])
		dialog_tree = dialog_tree.states[i]
		execute_tree()
	
	
func _dialog_selected(index: int):
	# remove the old buttons
	clear_children(buttonBox)
	# remove the old thoughts
	# show selected option
	add_speech(dialog_tree.speaker, dialog_tree.choices[index])
	# advance the tree
	if dialog_tree.states.size() == 0:
		return
	dialog_tree = dialog_tree.states[index]

	execute_tree()


func recieve_conversing_event(conversing: bool, partner: String):
	self.visible = conversing
	if conversing:
		# Partner is the person who was looked at
		current_partner = partner
		self.dialog_tree = ConversationSingleton.get_conversation(partner)
		if self.dialog_tree == null:
			clear_ui()
		else:
			for entry in self.dialog_tree.history:
				add_speech(entry[0], entry[1])
			execute_tree()
	
func _exit_pressed():
	# Store conversation history in the node, or add a TERMINUS node for storage
	if self.dialog_tree == null:
		self.dialog_tree = DialogState.create("TERMINUS")
	self.dialog_tree.history = conversation
	ConversationSingleton.all_trees.trees[current_partner] = self.dialog_tree
	clear_ui()

func clear_ui():
	clear_children(buttonBox)
	clear_children(logContainer)
	self.queue_free()

func bottom_scroll():
	call_deferred("bottom_scroll_def")
	#scrollContainer.scroll_vertical = scrollContainer.get_v_scroll_bar().max_value
	
func bottom_scroll_def():
	# double defferral
	# https://forum.godotengine.org/t/how-to-get-scrollbar-to-automatically-scroll-to-bottom/74013/7
	scrollContainer.scroll_vertical = int(scrollContainer.get_v_scroll_bar().max_value)


func add_speech(speaker: String, text: String):
	conversation.append([speaker, text])
	if speaker == current_partner:
		add_line(text, BoxContainer.ALIGNMENT_END)
	else:
		add_line(text, BoxContainer.ALIGNMENT_BEGIN)

func add_line(text: String, alignment: HBoxContainer.AlignmentMode):
	var item: DialogBox = single_speech_box.instantiate()
	item.alignment = alignment
	item.text = text
	logContainer.add_child(item)
	call_deferred("bottom_scroll")
