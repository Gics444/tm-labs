extends Control

onready var pressed = $Structure1
signal structure_selected(selected_number)

func _ready() -> void:
	for button in get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button])

func _on_Button_pressed(button: Button) -> void:
	pressed.pressed = false
	pressed = button
	pressed.pressed = true
	emit_signal("structure_selected", button.get_child(0).text)
	
func _input(event):
	if event.is_action_pressed("1"):
		$Structure1.emit_signal("pressed")
	if event.is_action_pressed("2"):
		$Structure2.emit_signal("pressed")
