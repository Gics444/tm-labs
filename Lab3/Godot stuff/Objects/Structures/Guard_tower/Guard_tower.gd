extends KinematicBody2D

var guard_count = 0
var guardRef = preload("res://Objects/Entities/Square_(Guard)/Guard.tscn")

signal segment_changed(num)

func _physics_process(delta):
	var nest_hitbox = get_node("Nest_hitbox")
	for bodies in nest_hitbox.get_overlapping_bodies():
		if bodies.is_in_group("Enemy"):
			take_dmg_from_pest(delta)
	if $TextureProgress.value <= 0:
		dead()

func _process(delta):
	if guard_count < 3 && get_parent().current_segments>=3:
		var guardObj = guardRef.instance()
		guardObj.global_position = Vector2(512, 200)
		add_child(guardObj)
		guard_count += 1
		get_parent().current_segments -=3
		emit_signal("segment_changed", get_parent().current_segments)
			
func _ready():
	connect("segment_changed", get_parent(), "on_segments_changed")
	for i in range(3):
		var guardObj = guardRef.instance()
		guardObj.position = position
		add_child(guardObj)
		guard_count += 1
		
func take_dmg_from_pest(delta):
	$TextureProgress.value = $TextureProgress.value - 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func dead():
	queue_free()
