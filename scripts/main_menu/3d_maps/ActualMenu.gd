extends Node

onready var idleNode = $Environment/idle2.get_node("AnimationPlayer")
onready var animationNode = $UserInterface/AnimationPlayer
onready var parentNode = get_parent()
onready var characterNode = $Environment/character_animations
onready var characterNodeAnim = $Environment/character_animations/AnimationPlayer
onready var shopNodeAnimPlayer = $UserInterface/ShopPanel/CanvasLayer/AnimationPlayer
onready var userNameLabel = $UserInterface/Panel/Username
onready var coinsLabel = $UserInterface/Panel/Currency
onready var energyLabel = $UserInterface/Panel/Panel/Energy
onready var inventoryNodeAnim = $UserInterface/Inventory/CanvasLayer/AnimationPlayer
onready var moreEnergyButton = $UserInterface/Panel/Panel/Button

var actionPressed = null
var energyAvailable = null

func _ready():
	parentNode = get_parent()
	idleNode.get_animation("Root|Root|Root|mixamocom|Layer0").loop = true
	idleNode.play("Root|Root|Root|mixamocom|Layer0")
	
	energyAvailable = parentNode._getEnergy()
	
	if(energyAvailable < 5):
		moreEnergyButton.visible = true
	else:
		moreEnergyButton.hide()
	
	userNameLabel.bbcode_text = "[center] Welcome back,\n" + parentNode._getUserName() + "[/center]"
	coinsLabel.bbcode_text = "[center] COINS\n" + str(parentNode._getCoins()) + "[/center]"
	energyLabel.bbcode_text = "[center] ENERGY\n" + str(parentNode._getEnergy()) + "/5[/center]"

func _getInventory():
	return get_parent()._getInventory()
	
func _process(_delta):
	$UserInterface/RichTextLabel.bbcode_text = "[center]" + str(Engine.get_frames_per_second()) + "[/center]"

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

func _on_Shop_pressed():
	shopNodeAnimPlayer.play("FadIn")
	
func _on_Inventory_pressed():
	inventoryNodeAnim.play("FadIn")
	
func _addToInventory(item):
	parentNode._incrementInventoryItem(item)
	
func _saveOpenedItem(item):
	parentNode._tollCrateOpenedItemSave(item)
	
func _getItemData2():
	return get_parent()._getItemData()
