extends KinematicBody2D

signal core_under_attack(b)

func _ready():
	connect("core_under_attack", get_parent(), "_on_core_under_attack")

func _physics_process(delta):
	var core_hitbox = get_node("Core_hitbox")
	var bodies = core_hitbox.get_overlapping_bodies()
	if bodies.size() == 0:
		emit_signal("core_under_attack", false)
	for body in bodies:
		if body.is_in_group("Enemy"):
			emit_signal("core_under_attack", true)
			take_dmg_from_pest(delta)
		else:
			emit_signal("core_under_attack", false)
	if $TextureProgress.value <= 0:
		dead()
	
func take_dmg_from_pest(delta):
	$TextureProgress.value = $TextureProgress.value - 1
	
func dead():
	var spr = Sprite.new()
	var world = $".."
	spr.texture = load("res://Main_Scene_(World)/Plombit_yawn_3.jpg")
	spr.position = $"../Circle_(Player)".global_position
	spr.scale = Vector2(0.5,0.5)
	world.add_child(spr)
	$"..".get_tree().paused = true
	var popup = world.get_node("GameOverPopup")
	popup.rect_position = spr.position
	popup.show()
	queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

