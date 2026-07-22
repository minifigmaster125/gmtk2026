class_name TextRevealComponent extends Control

## How fast this component reveals characters of the parent label
@export_range(1.0, 50.0) var characters_per_second : float = 20.0
## If true, start as soon as ready in scene
@export var auto_start : bool = true
## How long to pause at a newline
@export_range(1., 50.) var newline_pause_multiplier : float = 10.0
## Optional audio stream that will be set to bus "SFX". Audio for this
## should be short so it can be repeated very fast if needed.
@export var audio_stream_player: AudioStreamPlayer

var _label : RichTextLabel
var _full_text : String = ""
var _is_revealing : bool = false
var _reveal_complete: bool = false

signal reveal_finished

func _ready() -> void:
	_label = get_parent()
	_full_text = _label.text
	_label.visible_characters = 0

	if audio_stream_player:
		audio_stream_player.bus = "SFX"
	if auto_start:
		if audio_stream_player:
			audio_stream_player.play()	
		start_reveal()

func start_reveal() -> void:
	if _is_revealing:
		return
	_is_revealing = true
	_reveal_text()

func skip_reveal() -> void:
	_is_revealing = false
	_label.visible_characters = -1
	_reveal_complete = true
	if audio_stream_player:
		audio_stream_player.stream_paused = false
		if audio_stream_player.playing:
			audio_stream_player.stop()

func _reveal_text() -> void:
	var total_chars := _label.get_total_character_count()
	var delay := 0.0
	if characters_per_second > 0.0:
		delay = 1.0 / characters_per_second
	var base_delay := delay
	for index in total_chars:
		if not _is_revealing:
			return
		if audio_stream_player:
			if audio_stream_player.playing == false:
				audio_stream_player.play()
			audio_stream_player.pitch_scale = randf_range(0.9, 1.1)
		_label.visible_characters = index + 1
		delay = base_delay
		if delay > 0.0 and _label.text[index] == "\n":
			if audio_stream_player:
				audio_stream_player.stream_paused = true
			delay *= newline_pause_multiplier
		if delay > 0.0:
			await get_tree().create_timer(delay).timeout
	_label.visible_characters = -1
	_reveal_complete = true
	_is_revealing = false
	if audio_stream_player:
		audio_stream_player.stream_paused = false
		audio_stream_player.stop()
	reveal_finished.emit()
