extends Button
var Savedata = ConfigFile.new()
	
func _ready() -> void:
	Savedata.load("user://dev.save")
	for save in Savedata.get_sections():
		GlobalData.wins = Savedata.get_value(save, "wins")
		GlobalData.loses = Savedata.get_value(save, "loses")
	print("Game loaded")
	print(GlobalData.wins)
	print(GlobalData.loses)


# Starts the game
func _on_spelet_pressed() -> void:
	get_tree().change_scene_to_file("res://Game/Game.tscn")

# Rules
func _on_noteikumi_pressed() -> void:
	get_tree().change_scene_to_file("res://Homescreen/noteikumi.tscn")
