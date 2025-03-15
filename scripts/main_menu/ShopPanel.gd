extends Node2D

onready var animationPlayerNode = $CanvasLayer/AnimationPlayer
onready var parentNode = get_parent()
onready var infoPanelAnim = $CanvasLayer/Panel/InfoPanel/AnimationPlayer
onready var rollBar = $CanvasLayer/Panel/InfoPanel/Control2
onready var infoPanel = $CanvasLayer/Panel/InfoPanel
onready var coinsLabel = $CanvasLayer/Panel/Title2
onready var audioPlayer = $CanvasLayer/Panel/AudioStreamPlayer2D
onready var checkOut = preload("res://assets/sounds/cashier-quotka-chingquot-sound-effect-129698.mp3")

var infoPanelActive = false
var finishOpening = false
var startRolling = false

func _ready():
	_update_label()

func _on_Button3_pressed():
	if(startRolling == false):
		if(infoPanelActive == false):
			animationPlayerNode.play("FadOut")
			parentNode._fadeOutMusic()
		else:
			infoPanelActive = false
			infoPanelAnim.play("GetSmall")
		audioPlayer.stop()

func _on_Button4_pressed():
	infoPanelAnim.play("GetSmall")
	finishOpening = true
	infoPanelActive = false
	rollBar._revertItems()
	audioPlayer.stop()
	
func _update_coins_value():
	return parentNode._getCoins()

func _update_energy_value():
	return parentNode._getEnergy()
	
func _update_label():
	coinsLabel.bbcode_text = "[center] COINS: " + str(_update_coins_value()) + " | ENERGY: " + str(_update_energy_value()) + "[/center]"

func _on_Item1_mouse_entered():
	infoPanel.item = "toolcrate"
	infoPanelAnim.play("GetBig")
	infoPanelActive = true

func _on_Item2_mouse_entered():
	infoPanel.item = "skincrate"
	infoPanelAnim.play("GetBig")
	infoPanelActive = true

func _on_Item3_mouse_entered():
	infoPanel.item = "energybottle"
	infoPanelAnim.play("GetBig")
	infoPanelActive = true

func _on_Item4_mouse_entered():
	infoPanel.item = "trapcrate"
	infoPanelAnim.play("GetBig")
	infoPanelActive = true
	
func _addToInventory(item):
	parentNode._incrementInventoryItem(item)
	$CanvasLayer/Panel/InfoPanel/AnimationPlayer.play("GetSmall")

func _saveOpenedItem(item):
	parentNode._tollCrateOpenedItemSave(item)
	
func _energyBottlePopped():
	parentNode._addEnergy(5)
	infoPanelActive = false
	infoPanelAnim.play("GetSmall")
	_update_label()

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "FadOut"):
		parentNode._load_actual_menu()
		self.queue_free()
	if(anim_name == "OpenCaseo"):
		print("Open animation finished")
		rollBar._rollTheBar()
