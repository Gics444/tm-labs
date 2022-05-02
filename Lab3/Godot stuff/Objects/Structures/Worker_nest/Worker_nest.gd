extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Worker1").worker_poz = get_node("Worker1_poz") # Replace with function body.
	get_node("Worker2").worker_poz = get_node("Worker2_poz")
	get_node("Worker3").worker_poz = get_node("Worker3_poz")
	
func _physics_process(delta):
	var nest_hitbox = get_node("Nest_hitbox")
	for bodies in nest_hitbox.get_overlapping_bodies():
		if bodies.is_in_group("Enemy"):
			take_dmg_from_pest(delta)
	if $TextureProgress.value <= 0:
		dead()
	var collecting_area = get_node("Collecting_area")
	var worker1 = get_node("Worker1")
	var worker2 = get_node("Worker2")
	var worker3 = get_node("Worker3")
	var free_worker = null
	for bodies in collecting_area.get_overlapping_areas():
		if bodies.is_in_group("Shape_essence"):
			var se = bodies.get_parent()
			if se.assigned_worker == null and se.valid == true:
				if worker1 != null and (worker1.shape_target == worker1.worker_poz.global_position or worker1.shape_target == null):
					free_worker = worker1
				elif worker2 != null and  (worker2.shape_target == worker2.worker_poz.global_position or worker2.shape_target == null):
					free_worker = worker2
				elif worker3 != null and  (worker3.shape_target == worker3.worker_poz.global_position or worker3.shape_target == null):
					free_worker = worker3
				else:
					free_worker = null
				if free_worker != null:
					se.assigned_worker = free_worker
					free_worker.shape_target = se.global_position
					
func take_dmg_from_pest(delta):
	$TextureProgress.value = $TextureProgress.value - 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func dead():
	queue_free()
