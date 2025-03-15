extends Camera

func _ready():
	pass

func _process(delta):
	self.position.z += 2 * delta
