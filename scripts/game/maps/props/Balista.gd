extends Spatial

onready var arrowNode = $siege_balista_arrow
onready var parentNode = get_parent().get_parent().get_parent().get_parent()
onready var material = preload("res://assets/models/props/colormap.material")
onready var masterNode = get_parent().get_parent().get_parent().get_parent().get_parent()

onready var damageText = $CPUParticles

var hitpoints = 100
var bulletDamage = 1

func _ready():
	bulletDamage = masterNode._getRate()["damage"]
	damageText.mesh.text = str(bulletDamage)

func _process(delta):
	arrowNode.position.x += 5.5 * delta

func _on_Area_body_entered(body):
	if(body.name == "Player" and hitpoints > 0):
		parentNode._game_over()
	if(body.name == "Bullet" and hitpoints > 0):
		if(hitpoints - bulletDamage > 0):
			hitpoints -= bulletDamage
			damageText.restart()
		else:
			self.queue_free()
