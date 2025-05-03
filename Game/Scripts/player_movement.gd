extends CharacterBody2D


@export var atrums = 400

# Movement (Keyboard)
func get_input():
	var input = Input.get_vector("left", "right", "up", "down")
	velocity = input * atrums
	print(input)
	
func buttons():
	var buttons = Input.get_vector("left", "right", "up", "down")
	velocity = buttons * atrums
	
# Delta time bullshit
func _physics_process(delta):
	get_input() #input
	move_and_slide() #movement


#buttons
func _on_up_button_up() -> void:
	Input.action_release("up")
func _on_up_button_down() -> void:
	Input.action_press("up")
func _on_down_button_up() -> void:
	Input.action_release("down")
func _on_down_button_down() -> void:
	Input.action_press("down")
func _on_right_button_up() -> void:
	Input.action_release("right")
func _on_right_button_down() -> void:
	Input.action_press("right")
func _on_left_button_up() -> void:
	Input.action_release("left")
func _on_left_button_down() -> void:
	Input.action_press("left")
