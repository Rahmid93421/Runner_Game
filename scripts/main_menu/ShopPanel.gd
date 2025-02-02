extends Node2D

onready var animationPlayerNode = $CanvasLayer/AnimationPlayer
onready var parentNode = get_parent().get_parent()
onready var infoPanelAnim = $CanvasLayer/Panel/InfoPanel/AnimationPlayer
onready var rollBar = $CanvasLayer/Panel/InfoPanel/Control2
onready var infoPanel = $CanvasLayer/Panel/InfoPanel

var infoPanelActive = false

func _on_Button3_pressed():
	if(infoPanelActive == false):
		animationPlayerNode.play("FadOut")
	else:
		infoPanelActive = false
		infoPanelAnim.play("GetSmall")

func _on_Button4_pressed():
	infoPanelAnim.play("GetSmall")
	infoPanelAnim.play("RevertOpenCaseo")
	rollBar._revertItems()

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
	parentNode._addToInventory(item)
	$CanvasLayer/Panel/InfoPanel/AnimationPlayer.play("GetSmall")

func _saveOpenedItem(item):
	parentNode._saveOpenedItem(item)
