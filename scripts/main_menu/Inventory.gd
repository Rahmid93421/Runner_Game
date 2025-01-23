extends Node2D

onready var parentNode = get_parent()
onready var animNode = $CanvasLayer/AnimationPlayer
onready var canvasNode = $CanvasLayer/Panel
onready var baseItem = preload("res://scenes/main_menu/Item.tscn")
onready var animNodeInfoPanel = $CanvasLayer/Panel/InfoPanel/AnimationPlayer
onready var itemsNode = $CanvasLayer/Panel/Items
onready var infoPanel = $CanvasLayer/Panel/InfoPanel

var itemsNodeChildren
var names = ["toolcrate", "skincrate", "trapcrate", "energybottle"]
var naming = {"toolcrate": "Tool crate", "skincrate": "Skin crate", "trapcrate": "Trap crate", "energybottle": "Energy bottle"}
var inventory = {"toolcrate": 0, "skincrate": 0, "trapcrate": 0, "energybottle": 0, "skins": [], "weapons": []}
var item = 0
var infoPanelActive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	parentNode = get_parent().get_parent()
	itemsNodeChildren = itemsNode.get_children()
	
	for itemx in itemsNodeChildren:
		itemx.hide()
	
func _buildItems():
	item = 0
	var texturesDict = {
		"toolcrate": preload("res://assets/sprites/shop/items/crate.png"),
		"skincrate": preload("res://assets/sprites/shop/items/skin_crate.png"),
		"trapcrate": preload("res://assets/sprites/shop/items/trap_crate.png"),
		"energybottle": preload("res://assets/sprites/shop/items/energy_bottle.png")
	}
	for name in names:
		if(inventory[name] > 0):
			itemsNodeChildren[item].visible = true
			itemsNodeChildren[item].item = name
			itemsNodeChildren[item].get_node("TextureRect").texture = texturesDict[name]
			itemsNodeChildren[item].get_node("RichTextLabel").bbcode_text = "[center]" + naming[name] + "[/center]"
			itemsNodeChildren[item].get_node("RichTextLabel2").bbcode_text = "[center] x" + str(inventory[name]) + "[/center]"
			item += 1
			
func _on_AnimationPlayer_animation_started(anim_name):
	if(anim_name == "FadIn"):
		inventory = get_parent().get_parent()._getInventory()
		_buildItems()

func _on_Button3_pressed():
	if(infoPanelActive == false):
		animNode.play("FadOut")
	else:
		infoPanelActive = false
		animNodeInfoPanel.play("GetSmall")

func _on_Button_pressed():
	infoPanelActive = false
	animNodeInfoPanel.play("GetSmall")
