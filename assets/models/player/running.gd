extends Spatial

onready var skin = preload("res://assets/models/player/skin_002.material")

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Root/Skeleton/characterMedium").set_surface_material(0, skin)

