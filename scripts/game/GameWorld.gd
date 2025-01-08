extends Node

onready var coinsLabel = $CanvasLayer/RichTextLabel
onready var actualMainMenu = preload("res://scenes/main_menu/ActualMenu.tscn")
onready var parentNode = get_parent()
var coins = 0
var gameOver = false

func _ready():
	_update_coins_label()

func _process(_delta):
	pass
	
func _update_coins_label():
	coinsLabel.bbcode_text = "[center]" + str(coins) + "[/center]"
	
func _update_coins():
	coins += 1
	_update_coins_label()
	
func _game_over():
	gameOver = true

func _load_actual_main_menu():
	var instance = actualMainMenu.instance()
	parentNode.add_child(instance)
	self.queue_free()
