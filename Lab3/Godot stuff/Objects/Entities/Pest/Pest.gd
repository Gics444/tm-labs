extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var motion = Vector2()
signal segment_changed(num)

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
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("segment_changed", $"../..", "on_segments_changed")

func _physics_process(delta):
	var hitbox = get_node("Hitbox")
	for bodies in hitbox.get_overlapping_bodies():
		if bodies.is_in_group("Guard"):
			take_dmg_from_guard(delta)
	if $TextureProgress.value <= 0:
		dead()
	var attack_obj = find_closest_or_furthest(self, "Ally")
	if attack_obj != null:
		global_position += (attack_obj.global_position - (global_position))/100
		look_at(attack_obj.global_position)
		move_and_collide(motion)
	else:	
		var spr = Sprite.new()
		var world = $"../.."
		spr.texture = load("res://Main_Scene_(World)/Plombit_yawn_3.jpg")
		spr.position = $"../../Circle_(Player)".global_position
		spr.scale = Vector2(0.5,0.5)
		world.add_child(spr)
		$"../..".get_tree().paused = true
		var popup = world.get_node("GameOverPopup")
		popup.rect_position = spr.position
		popup.show()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func take_dmg_from_guard(delta):
	$TextureProgress.value = $TextureProgress.value - 1

func dead():
	$"../..".current_segments += 1
	emit_signal("segment_changed", $"../..".current_segments)
	queue_free()

