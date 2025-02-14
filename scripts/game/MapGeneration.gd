tool
extends Spatial

onready var straightPlatforms = [preload("res://scenes/game/maps/Map_1.tscn"), preload("res://scenes/game/maps/Map_2.tscn"), preload("res://scenes/game/maps/Map_3.tscn")]
onready var rng = RandomNumberGenerator.new()
onready var parentNode = get_parent().get_parent()

var platformsInstances = []
var currentDistance = 0
var maxPlatforms = 3
var currentDirection = null
var nextPosition = Vector3(0, 0, 0)

func _ready():
	_create_starting_platforms()
	
func _rng_number_params(minimum, maximum):
	rng.randomize()
	return rng.randi_range(minimum, maximum)

func _create_starting_platforms():
	currentDirection = "z"
	for _i in range(0, maxPlatforms):
		var id = _rng_number_params(0, 2);
		if(id == 2 && nextPosition.z == 0):
			id = 0
		var instance = straightPlatforms[id].instance()
		instance.position = nextPosition
		nextPosition.z += 15
		self.add_child(instance)

func _updatePosition(instance):
	instance.position = nextPosition
	match currentDirection:
		"z":
			nextPosition.z += 15

func _playerPunched():
	parentNode._game_over()
