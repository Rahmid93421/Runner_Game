tool
extends Spatial

onready var parentNode = get_parent()
onready var starPoint = preload("res://scenes/game/maps/props/StarPoint.tscn")
onready var rocksObstacle = preload("res://scenes/game/maps/props/Rocks.tscn")
onready var balistaObstacle = preload("res://scenes/game/maps/props/Balista.tscn")

onready var areaColision = $"wall-narrow-gate 2"

var positionPoint = Vector3(0.2, 0, -7.5)
var distPoint = 1.0
var endZAxis = 7.5
var pointsInstances = []

func _ready():
	_generate_points_clean()

func _generate_points_clean():
	while(positionPoint.z < endZAxis):
		var currentLinePoints = parentNode._rng_number_params(2, 3)
		if(positionPoint.z <= 0 && positionPoint.z >= -1):
			currentLinePoints = 1
		if(positionPoint.z >= 3 && positionPoint.z <= 4.3):
			currentLinePoints = 0
		for _i in currentLinePoints:
#			var chance = parentNode._rng_number_params(1, 100)
			var instance = null
			instance = starPoint.instance()
			instance.position = positionPoint
			self.add_child(instance)
			pointsInstances.append(instance)
			positionPoint.x -= 0.2
		positionPoint.x = 0.2
		positionPoint.z += distPoint

func _generate_points():
	while(positionPoint.z < endZAxis):
		var currentLinePoints = parentNode._rng_number_params(2, 3)
		if(positionPoint.z <= 0 && positionPoint.z >= -1):
			currentLinePoints = 1
		if(positionPoint.z >= 3 && positionPoint.z <= 4.3):
			currentLinePoints = 0
		for _i in currentLinePoints:
			var chance = parentNode._rng_number_params(1, 100)
			var instance = null
			if(chance > 25):
				instance = starPoint.instance()
			else:
				var type = parentNode._rng_number_params(1, 100)
				if(type > 75): # 25% chance for a balista
					print("Balista created")
					instance = balistaObstacle.instance()
				else:
					instance = rocksObstacle.instance()
			instance.position = positionPoint
			self.add_child(instance)
			pointsInstances.append(instance)
			positionPoint.x -= 0.2
		positionPoint.x = 0.2
		positionPoint.z += distPoint
		
func _free_points_instances():
	for i in pointsInstances:
		if(is_instance_valid(i)):
			i.queue_free()
	pointsInstances.empty()
	positionPoint = Vector3(-0.2, 0, -7.5)

func _on_Area_body_entered(body):
	if(body.name == "KinematicBody"):
		_free_points_instances()
		_generate_points()
		parentNode._updatePosition(self)
