extends Spatial

onready var straightPlatforms = [preload("res://scenes/game/maps/Map_1.tscn"), preload("res://scenes/game/maps/Map_2.tscn")]
onready var rng = RandomNumberGenerator.new()

var platformsInstances = []
var currentDistance = 0
var maxPlatforms = 3
var currentDirection = null
var nextPosition = Vector3(0, 0, 0)

func _ready():
	_create_starting_platforms()
	
func _process(_delta):
	pass
	
func _rng_number_params(minimum, maximum):
	rng.randomize()
	return rng.randi_range(minimum, maximum)

func _create_starting_platforms():
	currentDirection = "z"
	for _i in range(0, maxPlatforms):
		var instance = straightPlatforms[_rng_number_params(0, 1)].instance()
		instance.position = nextPosition
		nextPosition.z += 15
		self.add_child(instance)

func _updatePosition(instance):
	instance.position = nextPosition
	match currentDirection:
		"z":
			nextPosition.z += 15
