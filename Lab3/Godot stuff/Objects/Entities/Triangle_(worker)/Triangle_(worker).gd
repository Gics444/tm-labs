extends KinematicBody2D
var shape_target = null;
var motion = Vector2()
var worker_poz = null;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func find_closest_or_furthest(node: Object, group_name: String, get_closest:= true) -> Object:
	var target_group = get_tree().get_nodes_in_group(group_name)
	var distance_away
	var return_node
	if target_group.size() > 0:
		distance_away = node.global_transform.origin.distance_to(target_group[0].global_transform.origin)
		return_node = target_group[0]
		for index in target_group.size():
			var distance = node.global_transform.origin.distance_to(target_group[index].global_transform.origin)
			if get_closest == true && distance < distance_away:
				distance_away = distance
				return_node = target_group[index]
			elif get_closest == false && distance > distance_away:
				distance_away = distance
				return_node = target_group[index]
		return return_node
	else:
		return null

func _physics_process(delta):
	var nest_hitbox = get_node("Triangle_hitbox")
	for bodies in nest_hitbox.get_overlapping_bodies():
		if bodies.is_in_group("Enemy"):
			take_dmg_from_pest(delta)
	if $TextureProgress.value <= 0:
		dead()
		
	var shape_target_obj = find_closest_or_furthest(self, "Essence")
	if shape_target_obj != null:
		shape_target = shape_target_obj.global_position
		global_position += (shape_target - (global_position))/50
		look_at(shape_target)
		move_and_collide(motion)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func take_dmg_from_pest(delta):
	$TextureProgress.value = $TextureProgress.value - 1

func dead():
	queue_free()
