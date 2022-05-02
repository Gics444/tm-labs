extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var motion = Vector2()

func find_closest_or_furthest(node: Object, group_name: String, get_closest:= true) -> Object:
	var target_group = get_tree().get_nodes_in_group(group_name)
	var distance_away = node.global_transform.origin.distance_to(target_group[0].global_transform.origin)
	var return_node = target_group[0]
	for index in target_group.size():
		var distance = node.global_transform.origin.distance_to(target_group[index].global_transform.origin)
		if get_closest == true && distance < distance_away:
			distance_away = distance
			return_node = target_group[index]
		elif get_closest == false && distance > distance_away:
			distance_away = distance
			return_node = target_group[index]
	return return_node
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var attack_obj = find_closest_or_furthest(self, "Ally")
	global_position += (attack_obj.global_position - (global_position))/50
	look_at(attack_obj.global_position)
	move_and_collide(motion)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
