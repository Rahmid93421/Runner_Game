extends Node2D

onready var parentNode = get_parent()
onready var animNode = $CanvasLayer/AnimationPlayer
onready var canvasNode = $CanvasLayer/Panel
onready var animNodeInfoPanel = $CanvasLayer/Panel/InfoPanel/AnimationPlayer
onready var itemsNode = $CanvasLayer/Panel/Items
onready var infoPanel = $CanvasLayer/Panel/InfoPanel

var itemsNodeChildren
var names = ["toolcrate", "skincrate", "trapcrate", "energybottle"]
var naming = {"toolcrate": "Tool crate", "skincrate": "Skin crate", "trapcrate": "Trap crate", "energybottle": "Energy bottle"}
var inventory = {"toolcrate": 1, "skincrate": 0, "trapcrate": 0, "energybottle": 1}
var items = {
			"blasters": { 
				"8L4573R": [0, 0, 5],
				"8L4572R": [0, 0, 5],
				"8L4571R": [0, 0, 5],
				"8L4570R": [0, 0, 5],
				"8L4574R": [0, 0, 5],
				"8L4575R": [0, 0, 5],
				"8L4576R": [0, 0, 5]
			},
			"skins": {
				
			}
		}
var itemsName = {
	"8L4573R": "BLASTER#1",
	"8L4572R": "BLASTER#2",
	"8L4571R": "BLASTER#3",
	"8L4570R": "BLASTER#4",
	"8L4574R": "BLASTER#5",
	"8L4575R": "BLASTER#6",
	"8L4576R": "BLASTER#7"
}

var itemsRarity = {
	"8L4573R": "e8c213",
	"8L4572R": "e81313",
	"8L4571R": "e81313",
	"8L4570R": "e81313",
	"8L4574R": "134be8",
	"8L4575R": "134be8",
	"8L4576R": "134be8"
}

var item = 0
var infoPanelActive = false

# Called when the node enters the scene tree for the first time.
func _ready():
	parentNode = get_parent().get_parent()
	itemsNodeChildren = $CanvasLayer/Panel/Items.get_children()
	
	for itemx in itemsNodeChildren:
		itemx.hide()
	
func _buildItems():
#	itemsNodeChildren = $CanvasLayer/Panel/Items.get_children()
	item = 0
	var texturesDict = {
		"toolcrate": preload("res://assets/sprites/shop/items/crate.png"),
		"skincrate": preload("res://assets/sprites/shop/items/skin_crate.png"),
		"trapcrate": preload("res://assets/sprites/shop/items/trap_crate.png"),
		"energybottle": preload("res://assets/sprites/shop/items/energy_bottle.png")
	}
	
	var itemsDict = {
		"8L4573R": preload("res://assets/sprites/shop/guns/blasterG.png"),
		"8L4572R": preload("res://assets/sprites/shop/guns/blasterH.png"),
		"8L4571R": preload("res://assets/sprites/shop/guns/blasterQ.png"),
		"8L4570R": preload("res://assets/sprites/shop/guns/blasterA.png"),
		"8L4574R": preload("res://assets/sprites/shop/guns/blasterB.png"),
		"8L4575R": preload("res://assets/sprites/shop/guns/blasterC.png"),
		"8L4576R": preload("res://assets/sprites/shop/guns/blasterD.png")
	}
	for name in names:
		if(inventory[name] > 0):
			itemsNodeChildren[item].visible = true
			itemsNodeChildren[item].item = name
			itemsNodeChildren[item].get_node("TextureRect").texture = texturesDict[name]
			itemsNodeChildren[item].get_node("RichTextLabel").bbcode_text = "[center]" + naming[name] + "[/center]"
			itemsNodeChildren[item].get_node("RichTextLabel2").bbcode_text = "[center] x" + str(inventory[name]) + "[/center]"
			item += 1
	
	
	for name in itemsName:
		if(items['blasters'][name][2] > 0):
			itemsNodeChildren[item].get_stylebox("panel").border_color = itemsRarity[name]
			itemsNodeChildren[item].visible = true
			itemsNodeChildren[item].item = name
			itemsNodeChildren[item].get_node("TextureRect").texture = itemsDict[name]
			itemsNodeChildren[item].get_node("RichTextLabel").bbcode_text = "[center]" + name + "[/center]"
			itemsNodeChildren[item].get_node("RichTextLabel2").bbcode_text = "[center] x" + str(items['blasters'][name][2]) + "[/center]"
			item += 1
			
func _on_AnimationPlayer_animation_started(anim_name):
	if(anim_name == "FadIn"):
		inventory = get_parent().get_parent()._getInventory()
		items = get_parent().get_parent()._getItemData2()
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
