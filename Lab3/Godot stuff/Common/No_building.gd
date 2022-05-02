extends Area2D


const PLAYER_NAME = "Circle_(Player)"

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NoBuilding_body_entered(body):
	if(body.name == PLAYER_NAME):
		body.no_build_areas_entered += 1


func _on_NoBuilding_body_exited(body):
	if(body.name == PLAYER_NAME):
		body.no_build_areas_entered -= 1
