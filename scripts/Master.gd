extends Node

onready var mainMenuNode = preload("res://scenes/main_menu/MainMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _intro_finished():
	_load_main_menu()

func _load_main_menu():
	var instance = mainMenuNode.instance()
	self.add_child(instance)
