extends Node

onready var mainMenuNode = preload("res://scenes/main_menu/MainMenu.tscn")
onready var gameWorldNode = preload("res://scenes/game/GameWorld.tscn")
onready var yodoNode = $Yodo1Mas
onready var yodoInitialized = false
onready var audioPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	yodoInitialized = yodoNode.init()
	_yodo_load_banner()

func _intro_finished():
	_load_main_menu()

func _load_main_menu():
	var instance = mainMenuNode.instance()
	self.add_child(instance)

func _load_game():
	var instance = gameWorldNode.instance()
	self.add_child(instance)

func _yodo_status():
	return yodoInitialized

func _play_audio_menu():
	audioPlayer.play()

func _yodo_load_banner():
	yodoNode.load_banner_ad("AdaptiveBanner", "RIGHT", "BOTTOM")
	
func _yodo_show_banner():
	yodoNode.show_banner_ad()
