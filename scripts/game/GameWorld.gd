extends Node

onready var coinsLabel = $CanvasLayer/RichTextLabel
onready var actualMainMenu = preload("res://scenes/main_menu/ActualMenu.tscn")
onready var parentNode = get_parent()
onready var cameraNode = $Spatial/Camera
onready var spatialNode = $Spatial
onready var bulletSplash = preload("res://scenes/game/maps/props/Bullet_Splash.tscn")
onready var bulletSplash6 = preload("res://scenes/game/maps/props/Bullet_Splash_6.tscn")
onready var bullet = preload("res://scenes/game/maps/props/Bullet.tscn")

var coins = 0
var gameOver = false
var multiplier = 1
var limitValue = 50

var waitRate = 0
var fireRate = 0.95
var spread = 1
var bulletsNum = 1

var positions = {
	"center": 0,
	"left": 0.20,
	"right": -0.20
}

var playerOnLane = "center"
var bullets = []

func _ready():
	fireRate = get_parent()._getRate()['firerate']
	spread = get_parent()._getRate()['spread']
	bulletsNum = get_parent()._getRate()['bullets']
	_update_coins_label()

func _process(delta):
	if(gameOver == false):
		if(waitRate < fireRate):
			waitRate += delta
		else:
			var instance = null
			match spread:
				0.5:
					if(bulletsNum == 3):
						instance = bulletSplash.instance()
					else:
						instance = bulletSplash6.instance()
				1.0:
					instance = bullet.instance()
			instance.position = Vector3(positions[playerOnLane], 1.25, cameraNode.position.z + 3)
			spatialNode.add_child(instance)
			bullets.append(instance)
			waitRate = 0

func _laneChanged(lane):
	playerOnLane = lane
	
func _update_coins_label():
	coinsLabel.bbcode_text = "[center]" + str(coins) + "[/center]"
	
func _update_coins():
	coins += 1
	if(coins % limitValue == 0):
		cameraNode.moveSpeed += 0.35
		coins += 10 * multiplier
		multiplier += 1
		limitValue *= 3
	_update_coins_label()
	
func _game_over():
	gameOver = true
	parentNode._setCoins(coins)

func _load_actual_main_menu():
	parentNode._load_actual_menu()
	self.queue_free()

func _on_AnimationPlayer_animation_started(anim_name):
	if(anim_name == "Outro"):
		parentNode._fadeOutMusic()
