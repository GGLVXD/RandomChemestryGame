extends Control
var Savedata = ConfigFile.new()

func _ready() -> void:
	# Load stats from save file
	Savedata.load_encrypted_pass("user://game.save", "DontBeAJerkAndDontCheat")
	for save in Savedata.get_sections():
		GlobalData.wins = Savedata.get_value(save, "wins")
		GlobalData.loses = Savedata.get_value(save, "loses")
		print("Game loaded")
	# Win stats
	var stats = Label.new()
	stats.text = "Uzvaras: " + type_convert(GlobalData.wins, TYPE_STRING) + "\nZaudes: " + type_convert(GlobalData.loses, TYPE_STRING)
	stats.add_theme_font_size_override("font_size", 24)
	stats.add_theme_color_override("font_color", Color(0, 0, 0))
	stats.position = Vector2(10, 10)
	add_child(stats)
	# Saves the game
	GlobalData.save()
	
