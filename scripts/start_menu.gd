extends Node2D


func _on_texture_button_pressed() -> void:
	%ratsound.play()
	await %ratsound.finished
	get_tree().change_scene_to_file("res://scenes/game.tscn")
