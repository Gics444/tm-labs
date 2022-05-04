extends KinematicBody2D

var movespeed = 300

var structure_number_selected = "1"
var no_build_areas_entered = 0

signal essence_changed(num)
signal segment_changed(num)
signal spell_cost_increased(num)

onready var world = $".."
onready var spellZone = $SpellZone
onready var spellShape = $SpellZone/SpellShape
onready var spellVisibility = $SpellZone/SpellShape/ColorRect
onready var timer = $SpellZone/Timer

var spellCost = 5

func _ready():
	connect("essence_changed", world, "on_essence_changed")
	connect("segment_changed", world, "on_segments_changed")
	$SpellZone/SpellShape/ColorRect.visible = false

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
	
	if !spellShape.disabled:
		var bodies_in_area = spellZone.get_overlapping_bodies()
		for body in bodies_in_area:
			if body.is_in_group("Enemy"):
				body.dead()
	
	
func _input(event):
	if event.is_action_pressed("ui_select") :
		if structure_number_selected == "1" && no_build_areas_entered == 0:
			if world.current_essence >=4:
				var structure = load("res://Objects/Structures/Worker_nest/Worker_nest.tscn").instance()
				world.add_child(structure)
				structure.position = position
				world.current_essence-=4
				emit_signal("essence_changed", world.current_essence)
		elif structure_number_selected == "2" && no_build_areas_entered == 0:
			if world.current_essence >=8 && world.current_segments >=4:
				var structure = load("res://Objects/Structures/Guard_tower/Guard_tower.tscn").instance()
				world.add_child(structure)
				structure.position = position
				world.current_essence-=8
				emit_signal("essence_changed", world.current_essence)
				world.current_segments -=4
				emit_signal("segment_changed", world.current_segments)
		elif structure_number_selected == "3" && world.current_essence >= spellCost:
			world.current_essence-=spellCost
			emit_signal("essence_changed", world.current_essence)
			spellCost += 1
			emit_signal("spell_cost_increased", spellCost)
			timer.start()
			spellVisibility.visible = true
			spellShape.disabled = false

func _on_selected_structure(structure_number):
	structure_number_selected = structure_number
	
func _on_Timer_timeout():
	spellVisibility.visible = false
	spellShape.disabled = true
