extends Area2D

#@export_file var scene_path: String
@export var player : CharacterBody2D

const scene= preload("res://levels/level2_reception.tscn")

# func _ready():
# 	var scene_str := scene_path
# 	scene = preload("res://levels/level2_reception.tscn")
	
func _on_body_entered(body):
	print("collision")
	if body.is_in_group("player"):
		print("player collision")
		#if get_node("../..").keys >= get_node("../..").required_keys:
		player.process_mode = Node.PROCESS_MODE_DISABLED
		player.velocity = Vector2.ZERO
		# get_tree().change_scene_to_file.call_deferred(scene_path)
		get_tree().change_scene_to_packed(scene)
