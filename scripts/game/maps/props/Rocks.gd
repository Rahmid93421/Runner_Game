extends Spatial

onready var parentNode = get_parent().get_parent().get_parent().get_parent()
onready var masterNode = get_parent().get_parent().get_parent().get_parent().get_parent()
onready var damageText = $CPUParticles

var hitpoints = 100
var bulletDamage = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	bulletDamage = masterNode._getRate()["damage"]
	damageText.mesh.text = str(bulletDamage)

func _on_Area_body_entered(body):
	if(body.name == "Player" and hitpoints > 0):
		parentNode._game_over()
	if(body.name == "Bullet" and hitpoints > 0):
		if(hitpoints - bulletDamage > 0):
			hitpoints -= bulletDamage
			damageText.restart()
		else:
			self.queue_free()
			# add destroyed particles
