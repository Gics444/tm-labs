extends Node2D
var spawn_count = 1
var essence_count = 0
var essence_limit = 15

var current_essence = 0
var current_segments = 0

func _ready():
	randomize()
	$Camera2D/CanvasLayer/UI/ButtonGroup.connect("structure_selected", $"Circle_(Player)", "_on_selected_structure")
	$"Circle_(Player)".connect("spell_cost_increased", $Camera2D/CanvasLayer/UI/ButtonGroup, "_on_spell_cost_increase")

var pest_nest = preload("res://Objects/Structures/Pest_Deepnest/Pest_Deepnest.tscn")
var essence = preload("res://Objects/Structures/Shape_essence/Shape_essence.tscn")

func _on_SpawnTimer_timeout():
	for i in int(spawn_count):
		var nest = pest_nest.instance()
		add_child(nest)
	
		var spawn_loc = $ExpandingBack/Path2D/PathFollow2D
		spawn_loc.offset = randi()
	
		nest.position = spawn_loc.global_position

func _on_EssenceSpawnTimer_timeout():
	if essence_count < essence_limit:
		var essence_obj = essence.instance()
		add_child(essence_obj)
		essence_count+=1
		
		var spawn_loc = $ExpandingBack/EssenceSpawns/PathFollow2D
		spawn_loc.offset = randi()
		
		essence_obj.position = spawn_loc.global_position

func on_essence_changed(num):
	$Camera2D/CanvasLayer/UI/EssenceLabel.text = str(num)

func on_segments_changed(num):
	$Camera2D/CanvasLayer/UI/SegmentLabel.text = str(num)
	
func _on_core_under_attack(b):
	if b: $Camera2D/CanvasLayer/UI/attack.show()
	else: $Camera2D/CanvasLayer/UI/attack.hide()
