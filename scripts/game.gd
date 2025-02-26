extends Node2D



func spawn_mob():
	var new_mob = preload("res://scenes/mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)
	
	

func _on_timer_timeout() -> void:
	spawn_mob()


func _on_rat_health_depleted() -> void:
	%GameOver.visible = true
	Engine.time_scale = 0.02
	
func _on_texture_button_pressed() -> void:
	Points.points = 0
	get_tree().reload_current_scene()
	Engine.time_scale = 1
	
