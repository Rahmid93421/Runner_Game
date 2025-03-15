extends Spatial

onready var parentNode = get_parent().get_parent().get_parent().get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Area_body_entered(body):
	if(body.name == "Player"):
		parentNode._update_coins()
		self.queue_free()
