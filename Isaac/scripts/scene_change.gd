extends Area2D

@export_file var scene_path: String

func _on_body_entered(body):
	print("collision")
	if body.is_in_group("player"):
		print("player collision")
		#if get_node("../..").keys >= get_node("../..").required_keys:
		get_tree().change_scene_to_file.call_deferred(scene_path)
