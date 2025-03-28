extends Node

onready var idleNode = $Environment/idle2.get_node("AnimationPlayer")
onready var animationNode = $UserInterface/AnimationPlayer
onready var parentNode = get_parent()
onready var characterNode = $Environment/character_animations
onready var characterNodeAnim = $Environment/character_animations/AnimationPlayer
onready var userNameLabel = $UserInterface/Panel/Username
onready var coinsLabel = $UserInterface/Panel/Currency
onready var energyLabel = $UserInterface/Panel/Panel/Energy
onready var audioPlayer = $AudioStreamPlayer2D
onready var audioPlayer2 = $AudioStreamPlayer2D2

var actionPressed = null
var energyAvailable = null

func _ready():
	parentNode = get_parent()
	idleNode.get_animation("Root|Root|Root|mixamocom|Layer0").loop = true
	idleNode.play("Root|Root|Root|mixamocom|Layer0")
	
	energyAvailable = parentNode._getEnergy()
	
	userNameLabel.bbcode_text = "[center] Welcome back,\n" + parentNode._getUserName() + "[/center]"
	coinsLabel.bbcode_text = "[center] COINS\n" + str(parentNode._getCoins()) + "[/center]"
	energyLabel.bbcode_text = "[center] ENERGY\n" + str(parentNode._getEnergy()) + "[/center]"

func _getInventory():
	return get_parent()._getInventory()
	
func _process(_delta):
	$UserInterface/RichTextLabel.bbcode_text = "[center]" + str(Engine.get_frames_per_second()) + "[/center]"

func _on_Play_pressed():
	if(energyAvailable <= 0):
		animationNode.play("FadeIn")
	else:
		actionPressed = "play"
		animationNode.play("OutroAnim")

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "OutroAnim"):
		animationNode.play("MakePlayerRun")
		audioPlayer2.play()
		$Environment/idle2.hide()
		characterNode.visible = true
		characterNodeAnim.play("Root|mixamocom|Layer0")
		audioPlayer.play()
	if(anim_name == "MakePlayerRun"):
		audioPlayer2.stop()
		characterNodeAnim.get_animation("Root|mixamocom|Layer0004").loop = true
		characterNodeAnim.play("Root|mixamocom|Layer0004")
		animationNode.play("RealOutro")
	if(anim_name == "RealOutro"):
		match actionPressed:
			"play":
				parentNode._load_game()
			"shop":
				parentNode._load_shop()
			"inventory":
				parentNode._load_inventory()
		self.queue_free()

func _on_Shop_pressed():
	animationNode.play("OutroAnim")
	actionPressed = "shop"
	
func _on_Inventory_pressed():
	animationNode.play("OutroAnim")
	actionPressed = "inventory"
	
func _addToInventory(item):
	parentNode._incrementInventoryItem(item)
	
func _saveOpenedItem(item):
	parentNode._tollCrateOpenedItemSave(item)
	
func _getItemData2():
	return get_parent()._getItemData()

func _energyBottlePopped():
	parentNode._addEnergy(5)
	energyLabel.bbcode_text = "[center] ENERGY\n" + str(parentNode._getEnergy()) + "/5[/center]"
	
func _useToolCrate():
	parentNode._useToolCrate()

func _on_Item3_mouse_entered():
	pass # Replace with function body.

func _on_AnimationPlayer_animation_started(anim_name):
	if(anim_name == "RealOutro"):
		parentNode._fadeOutMusicMenu()

func _on_Button_buy_energy_pressed():
	pass # Replace with function body.
