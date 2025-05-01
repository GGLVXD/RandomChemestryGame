extends Button

# Starts the game
func _on_spelet_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/Game.tscn")

# Rules
func _on_noteikumi_pressed() -> void:
	get_tree().change_scene_to_file("res://Homescreen/noteikumi.tscn")
