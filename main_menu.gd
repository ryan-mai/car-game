extends Node2D


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://game.tscn")


func _on_settings_pressed() -> void:
	pass # Replace with function body.


func _on_login_pressed() -> void:
	get_tree().quit()
