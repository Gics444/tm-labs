extends KinematicBody2D

var movespeed = 300

var structure_number_selected = "1"
var no_build_areas_entered = 0

func _physics_process(delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1
	if Input.is_action_pressed("right"):
		motion.x += 1
	
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	
func _input(event):
	print(no_build_areas_entered)
	if event.is_action_pressed("ui_select") && no_build_areas_entered == 0:
		if structure_number_selected == "1":
			var structure = load("res://Objects/Entities/Pest/Pest.tscn").instance()
			$"..".add_child(structure)
			structure.position = position
		elif structure_number_selected == "2":
			var structure = load("res://Objects/Structures/The_Core/The_Core.tscn").instance()
			$"..".add_child(structure)
			structure.position = position
			

func _on_selected_structure(structure_number):
	print(structure_number)
	structure_number_selected = structure_number
