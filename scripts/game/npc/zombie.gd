tool
extends Spatial

onready var materials = [preload("res://assets/models/npc/skin_001.material"), preload("res://assets/models/npc/skin_002.material")]
onready var characterNode = $Root/Skeleton/characterMedium

onready var rng = RandomNumberGenerator.new()

func _rng_number_params(minimum, maximum):
	rng.randomize()
	return rng.randi_range(minimum, maximum)

func _ready():
	characterNode.mesh.surface_set_material(0, materials[_rng_number_params(0, 1)])
