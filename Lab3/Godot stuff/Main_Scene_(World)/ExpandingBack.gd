extends Node2D

func _on_ExpansionTimer_timeout():
	$".".scale += Vector2(0.1,0.1)
