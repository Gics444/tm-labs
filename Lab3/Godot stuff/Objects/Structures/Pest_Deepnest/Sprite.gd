extends Sprite

export(Array, Texture) var TEXTURE_VARIATION_ARRAY: Array =[
	preload("res://Objects/Structures/Pest_Deepnest/pest1.png"),
	preload("res://Objects/Structures/Pest_Deepnest/pest2.png"),
	preload("res://Objects/Structures/Pest_Deepnest/pest3.png")
]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func variate_texture():
	if TEXTURE_VARIATION_ARRAY.size() > 1:
		var texture_id: int = randi() % TEXTURE_VARIATION_ARRAY.size()
		texture = TEXTURE_VARIATION_ARRAY[texture_id]

# Called when the node enters the scene tree for the first time.
func _ready():
	variate_texture(); # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
