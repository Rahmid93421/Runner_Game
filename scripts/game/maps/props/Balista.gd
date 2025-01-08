extends Spatial

onready var arrowNode = $siege_balista_arrow
onready var parentNode = get_parent().get_parent().get_parent().get_parent()

func _process(delta):
	arrowNode.position.x += 8.5 * delta

func _on_Area_body_entered(body):
	if(body.name == "Player"):
		parentNode._game_over()
