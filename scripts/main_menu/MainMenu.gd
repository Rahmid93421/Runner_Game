extends Node

onready var actualMainMenu = preload("res://scenes/main_menu/ActualMenu.tscn")
onready var animationNode = $CanvasLayer/AnimationPlayer
onready var parentNode = get_parent()

var yodoInitialized = false

func _ready():
	parentNode. _play_audio_menu()
	
func _process(_delta):
	$CanvasLayer/Title2.text = str(Engine.get_frames_per_second())

	if(yodoInitialized == true):
		parentNode._yodo_show_banner()
		yodoInitialized = false

func _on_Button_pressed():
	animationNode.play("OutroMenu")

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "OutroMenu"):
		var instance = actualMainMenu.instance()
		parentNode.add_child(instance)
		self.queue_free()

func _on_AnimationPlayer_animation_started(anim_name):
	pass
