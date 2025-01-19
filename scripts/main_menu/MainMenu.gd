extends Node

onready var actualMainMenu = preload("res://scenes/main_menu/ActualMenu.tscn")
onready var chooseAUsername = preload("res://scenes/main_menu/ChooseUsernamePanel.tscn")
onready var animationNode = $CanvasLayer/AnimationPlayer
onready var parentNode = get_parent()
onready var chooseUsername = $CanvasLayer/ChooseUsernamePanel/CanvasLayer/AnimationPlayer

var yodoInitialized = false
var letTheUserChooseAUsername = true

func _ready():
	parentNode._play_audio_menu()
	
	if(parentNode._checkIfSaveFileExists()):
		parentNode._loadFromFile()
		letTheUserChooseAUsername = false
	else:
		$CanvasLayer/Panel/Button.disabled = true
		parentNode._saveToFile() # create new save file
	
func _process(_delta):
#	$CanvasLayer/Title2.text = str(Engine.get_frames_per_second())

	if(yodoInitialized == true):
		parentNode._yodo_show_banner()
		yodoInitialized = false

func _saveUserName(username):
	parentNode._saveUserName(username)
	animationNode.play("OutroMenu")

func _on_Button_pressed():
	animationNode.play("OutroMenu")

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "OutroMenu"):
		var instance = actualMainMenu.instance()
		parentNode.add_child(instance)
		self.queue_free()
	if(anim_name == "IntroMenu"):
		if(letTheUserChooseAUsername == true):
			chooseUsername.play("Intro")

func _on_AnimationPlayer_animation_started(_anim_name):
	pass
