extends Node2D

@export var formulas = {
	"Metāli": ["Fe", "Cu", "Ag", "Al", "Zn"],
	"Nemetāli": ["O₂", "N₂", "Cl₂", "S", "C"],
	"Oksīdi": ["CO₂", "SO₂", "NO₂", "Al₂O₃", "Fe₂O₃"],
	"Skābes": ["HCl", "H₂SO₄", "HNO₃", "H₃PO₄", "HF"],
	"Bāzes": ["NaOH", "KOH", "Ca(OH)₂", "Ba(OH)₂", "NH₄OH"],
	"Sāļi": ["NaCl", "KNO₃", "CaCO₃", "MgSO₄", "CuSO₄"],
	"Organiskas vielas": ["CH₄", "C₂H₆", "C₆H₁₂O₆", "C₂H₅OH", "C₃H₈"]
}

var correct_formulas = []
var incorrect_formulas = []
var collected = []
var target_category = ""

func _ready():
	randomize_formulas()
	show_target_category()
	spawn_formulas()

func randomize_formulas():
	var categories = formulas.keys()
	target_category = categories[randi() % categories.size()]
	correct_formulas = formulas[target_category].slice(0, 5)

	incorrect_formulas = []
	var used_formulas = correct_formulas.duplicate()
	
	while incorrect_formulas.size() < 5:
		var random_category = categories[randi() % categories.size()]
		if random_category == target_category:
			continue
		
		var random_formula = formulas[random_category][randi() % formulas[random_category].size()]
		if random_formula not in used_formulas:
			incorrect_formulas.append(random_formula)
			used_formulas.append(random_formula)


func show_target_category():
	var label = Label.new()
	label.text = "Samekle visas: " + target_category
	label.add_theme_font_size_override("font_size", 24)
	label.position = Vector2(10, 10)
	add_child(label)

func spawn_formulas():
	var all_formulas = correct_formulas + incorrect_formulas
	all_formulas.shuffle()
	var used_positions = []
	for formula in all_formulas:
		var formula_node = Area2D.new()
		formula_node.monitoring = true
		formula_node.monitorable = true
		
		var label = Label.new()
		label.text = formula
		formula_node.add_child(label)
		
		var shape = CollisionShape2D.new()
		shape.shape = CircleShape2D.new()
		shape.shape.radius = 20
		formula_node.add_child(shape)
		
		var pos = get_random_position(used_positions)
		formula_node.position = pos
		
		formula_node.connect("body_entered", Callable(self, "_on_formula_collected").bind(formula_node, formula))
		add_child(formula_node)


func get_random_position(used_positions):
	var pos
	var min_distance = 100
	while true:
		pos = Vector2(randi_range(100, 700), randi_range(100, 500))
		var too_close = false
		for up in used_positions:
			if up.distance_to(pos) < min_distance:
				too_close = true
				break
		if not too_close:
			used_positions.append(pos)
			return pos

func _on_formula_collected(body, formula_node, formula):
	if body is CharacterBody2D:
		print("Saskāries ar:", formula)
		if formula in correct_formulas:
			collected.append(formula)
			formula_node.queue_free()
			if collected.size() == correct_formulas.size():
				get_tree().change_scene_to_file("res://Game/Pareizi/pareizi.tscn")
		else:
			var actual_category = "Nezināms"
			for category in formulas.keys():
				if formula in formulas[category]:
					actual_category = category
					break
			# Chatgpt bullshit i dunno what this does tbh
			GlobalData.incorrect_formula = formula
			GlobalData.correct_category = actual_category
			get_tree().change_scene_to_file("res://Game/Nepareizi/nepareizi.tscn")
