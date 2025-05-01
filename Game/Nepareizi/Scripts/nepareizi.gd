extends Node2D

# Wrong text
func _ready():
	var label = Label.new()
	label.text = "Tu pieskāries: " + GlobalData.incorrect_formula + "\nTas ir: " + GlobalData.correct_category
	label.add_theme_font_size_override("font_size", 24)
	label.add_theme_color_override("font_color", Color(0, 0, 0))
	label.position = Vector2(50, 50)
	add_child(label)
	# Restart button
	var button = Button.new()
	button.text = "spelē velreiz"
	button.position = Vector2(50, 150)
	button.connect("pressed", Callable(self, "_restarte"))
	add_child(button)

func _restarte():
	get_tree().change_scene_to_file("res://Homescreen/main.tscn")
