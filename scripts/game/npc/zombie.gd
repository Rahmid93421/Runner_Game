extends Spatial

onready var materials = [preload("res://assets/models/npc/skin_001.material"), preload("res://assets/models/npc/skin_002.material")]
onready var characterNode = $zombie/Root/Skeleton/characterMedium
onready var zombieNode = $zombie
onready var animationPlayer = $zombie/AnimationPlayer
onready var parentNode = get_parent()

onready var rng = RandomNumberGenerator.new()

var moveUnits = 6.0
var dead = false
var kill = false

func _rng_number_params(minimum, maximum):
	rng.randomize()
	return rng.randi_range(minimum, maximum)

func _ready():
	characterNode.mesh.surface_set_material(0, materials[_rng_number_params(0, 1)])
	animationPlayer.get_animation("Root|mixamocom|Layer0").loop = true
	animationPlayer.play("Root|mixamocom|Layer0")

func _process(delta):
	if(kill == false && dead == false):
		zombieNode.position.z += moveUnits * delta
#	print(delta)

func _on_Area_body_entered(body):
	if(body.name == "Player" && dead == false):
		animationPlayer.play("Root|mixamocom|Layer0002")
		kill = true
		parentNode._playerPunched()
	else:
		if(dead == false):
			animationPlayer.play("Root|mixamocom|Layer0001")
			dead = true
