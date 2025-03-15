extends Spatial

onready var head = $Head
onready var mesh = $MeshInstance
onready var meshLeft = $MeshInstance2
onready var meshLeftLeft = $MeshInstance5
onready var meshRight = $MeshInstance3
onready var meshRightRight = $MeshInstance4

var speedBullet = 7.5
var limitDistance = 25

func _process(delta):
	if(head.position.z > 25):
		self.queue_free()
	else:
		if(is_instance_valid(mesh)):
			mesh.position.z += speedBullet * delta
		head.position.z += speedBullet * delta
		
		if(is_instance_valid(meshLeft)):
			meshLeft.position.z += (speedBullet - 0.3) * delta
		
		if(is_instance_valid(meshLeftLeft)):
			meshLeftLeft.position.z += (speedBullet - 0.5) * delta
		
		if(is_instance_valid(meshRight)):
			meshRight.position.z += (speedBullet - 0.35) * delta
		
		if(is_instance_valid(meshRightRight)):
			meshRightRight.position.z += (speedBullet - 0.55) * delta

func _on_Area_body_entered(body):
	if(body.name != "Player" && body.name != "Bullet"):
		mesh.queue_free()

func _on_Area2_body_entered(body):
	if(body.name != "Player" && body.name != "Bullet"):
		meshRight.queue_free()

func _on_Area3_body_entered(body):
	if(body.name != "Player" && body.name != "Bullet"):
		meshRightRight.queue_free()

func _on_Area4_body_entered(body):
	if(body.name != "Player" && body.name != "Bullet"):
		meshLeft.queue_free()

func _on_Area5_body_entered(body):
	if(body.name != "Player" && body.name != "Bullet"):
		meshLeftLeft.queue_free()
