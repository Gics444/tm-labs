extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var spawn_chance = 5
var pest_count = 1

func spawn_pest(count):
	var scene_pest = load("res://Objects/Entities/Pest/Pest.tscn")
	while (count!=0):
		var pest_obj = scene_pest.instance()
		var pos_change_x = int(rng.randf_range(-50, 50))
		var pos_change_y = int(rng.randf_range(-50, 50))
		pest_obj.position.x = pest_obj.position.x + pos_change_x
		pest_obj.position.y = pest_obj.position.y + pos_change_y
		add_child(pest_obj)
		count -= 1
# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_chance = int(rng.randf_range(5, 25))

func _on_Timer_timeout():
	if spawn_chance >= int(rng.randf_range(0, 100)):
		spawn_pest(pest_count)
		pest_count = 1
	else:
		pest_count += 1
	
