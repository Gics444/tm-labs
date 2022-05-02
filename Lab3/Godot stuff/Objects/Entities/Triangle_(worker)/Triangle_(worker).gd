extends KinematicBody2D
var shape_target = null;
var motion = Vector2()
var worker_poz = null;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var nest_hitbox = get_node("Triangle_hitbox")
	for bodies in nest_hitbox.get_overlapping_bodies():
		if bodies.is_in_group("Enemy"):
			take_dmg_from_pest(delta)
	if $TextureProgress.value <= 0:
		dead()
	if shape_target != null:
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
