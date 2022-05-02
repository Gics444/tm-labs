extends KinematicBody2D
var assigned_worker = null
var valid = true
var nest_radius_node = null
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var collecting_area = get_node("Shape_area")
	for bodies in collecting_area.get_overlapping_bodies():
		if bodies.is_in_group("Ally"):
			if bodies.is_in_group("Worker"):
				valid = false
				assigned_worker = null
				for triangles in nest_radius_node.get_overlapping_bodies():
					if triangles.is_in_group("Worker"):
						triangles.shape_target = triangles.worker_poz.global_position
				get_parent().essence_count -= 1
				queue_free()
		if bodies.is_in_group("Player"):
			for triangles in nest_radius_node.get_overlapping_bodies():
				if triangles.is_in_group("Worker"):
					triangles.shape_target = triangles.worker_poz.global_position
			valid = false
			assigned_worker = null
			get_parent().essence_count -= 1
			queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

