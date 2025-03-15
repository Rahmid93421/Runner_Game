extends Spatial

onready var mesh = $MeshInstance
onready var meshLeft = $MeshInstance2
onready var meshRight = $MeshInstance3

var speedBullet = 7.5
var limitDistance = 25

func _process(delta):
	if(mesh.position.z > 25):
		self.queue_free()
	else:
		mesh.position.z += speedBullet * delta
		
		meshLeft.position.z += (speedBullet - 0.5) * delta
		
		meshRight.position.z += (speedBullet - 0.5) * delta


func _on_Area_body_entered(body):
	if(body.name != "Player" && body.name != "Bullet"):
		self.queue_free()
