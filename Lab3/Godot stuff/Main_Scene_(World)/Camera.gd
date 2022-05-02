extends Camera2D


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			zoom += Vector2(-0.1, -0.1)
		if event.button_index == BUTTON_WHEEL_DOWN:
			zoom += Vector2(0.1, 0.1)
