extends Spatial

onready var mesh = $MeshInstance
var speedBullet = 7.5
var limitDistance = 25

func _process(delta):
	if(mesh.position.z > 25):
		self.queue_free()
	else:
		mesh.position.z += 5.5 * delta


func _on_Area_body_entered(body):
	if(body.name != "Player"):
		self.queue_free()
