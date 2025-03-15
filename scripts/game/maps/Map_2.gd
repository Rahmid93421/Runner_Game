tool
extends Spatial

onready var parentNode = get_parent()
onready var starPoint = preload("res://scenes/game/maps/props/StarPoint.tscn")
onready var rocksObstacle = preload("res://scenes/game/maps/props/Rocks.tscn")
onready var balistaObstacle = preload("res://scenes/game/maps/props/Balista.tscn")
onready var zombie = preload("res://scenes/game/maps/props/zombie.tscn")

var positionPoint = Vector3(-0.2, 0, -7.5)
var distPoint = 1.0
var endZAxis = 7.5
var pointsInstances = []

var pointChance = 80
var balistaChance = 25
var zombieChance = 50
var rockChance = 100

func _ready():
	_generate_points_clean()

func _generate_points_clean():
	while(positionPoint.z < endZAxis):
		var currentLinePoints = parentNode._rng_number_params(1, 3)
		for _i in currentLinePoints:
#			var chance = parentNode._rng_number_params(1, 100)
			var instance = null
			instance = starPoint.instance()
			instance.position = positionPoint
			self.add_child(instance)
			pointsInstances.append(instance)
			positionPoint.x += 0.2
		positionPoint.x = -0.2
		positionPoint.z += distPoint

func _generate_points():
	while(positionPoint.z < endZAxis):
		var currentLinePoints = parentNode._rng_number_params(1, 3)
		for _i in currentLinePoints:
			var chance = parentNode._rng_number_params(1, 100)
			var instance = null
			if(chance < pointChance):
				instance = starPoint.instance()
			else:
				var type = parentNode._rng_number_params(1, 100)
				if(type < balistaChance):
					print("Balista created")
					instance = balistaObstacle.instance()
				else:
					if(type < zombieChance):
						print("Spawn zombie")
						instance = zombie.instance()
						instance.position.y = 1.18
					else:
						instance = rocksObstacle.instance()
			instance.position = positionPoint
			self.add_child(instance)
			pointsInstances.append(instance)
			positionPoint.x += 0.2
		positionPoint.x = -0.2
		positionPoint.z += distPoint
		
func _free_points_instances():
	for i in pointsInstances:
		if(is_instance_valid(i)):
			i.queue_free()
	pointsInstances.empty()
	positionPoint = Vector3(-0.2, 0, -7.5)

func _on_Area_body_entered(body):
	if(body.name == "CameraBody"):
		_free_points_instances()
		_generate_points()
		parentNode._updatePosition(self)
