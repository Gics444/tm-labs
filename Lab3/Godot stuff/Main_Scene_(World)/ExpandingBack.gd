extends Node2D

func _on_ExpansionTimer_timeout():
	$".".scale += Vector2(2,2)
	var world = get_parent()
	world.spawn_count += + 0.5
