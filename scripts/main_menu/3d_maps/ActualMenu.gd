extends Node

onready var idleNode = $Environment/idle2.get_node("AnimationPlayer")
onready var animationNode = $UserInterface/AnimationPlayer
onready var parentNode = get_parent()
onready var characterNode = $Environment/character_animations
onready var characterNodeAnim = $Environment/character_animations/AnimationPlayer

var actionPressed = null

func _ready():
	idleNode.get_animation("Root|Root|Root|mixamocom|Layer0").loop = true
	idleNode.play("Root|Root|Root|mixamocom|Layer0")
	
func _on_Play_pressed():
	actionPressed = "play"
	animationNode.play("OutroAnim")

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "OutroAnim"):
		animationNode.play("MakePlayerRun")
		$Environment/idle2.hide()
		characterNode.visible = true
		characterNodeAnim.play("Root|mixamocom|Layer0")
	if(anim_name == "MakePlayerRun"):
		characterNodeAnim.get_animation("Root|mixamocom|Layer0004").loop = true
		characterNodeAnim.play("Root|mixamocom|Layer0004")
		animationNode.play("RealOutro")
	if(anim_name == "RealOutro"):
		match actionPressed:
			"play":
				parentNode._load_game()
		self.queue_free()
