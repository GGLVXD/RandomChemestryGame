extends CharacterBody2D


@export var atrums = 400

# Movement (Keyboard)
func get_input():
	var input = Input.get_vector("left", "right", "up", "down")
	velocity = input * atrums
	
# Delta time bullshit
func _physics_process(delta):
	get_input() #input
	move_and_slide() #movement
