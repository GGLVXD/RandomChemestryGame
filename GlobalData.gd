extends Node
var Savedata = ConfigFile.new()

var incorrect_formula = ""
var correct_category = ""
var wins = 0
var loses = 0

func save() -> void:
	Savedata.set_value("save", "wins", GlobalData.wins)
	Savedata.set_value("save", "loses", GlobalData.loses)
	Savedata.save_encrypted_pass("user://game.save", "DontBeAJerkAndDontCheat")
	print("Saved")
