extends Panel

export var item = ""

onready var textureRect = $TextureRect
onready var panels = $Control
onready var itemName = $RichTextLabel
onready var parentNode = get_parent().get_parent().get_parent()

onready var texturesItems = {
	"toolcrate": preload("res://assets/sprites/shop/items/crate.png"),
	"skincrate": preload("res://assets/sprites/shop/items/skin_crate.png"),
	"energybottle": preload("res://assets/sprites/shop/items/energy_bottle.png"),
	"trapcrate": preload("res://assets/sprites/shop/items/trap_crate.png")
}

var itemsNames = {
	"toolcrate": "[center]Tool Crate[/center]",
	"energybottle": "[center]Energy Bottle (+5 energy)[/center]"
}

onready var items = {
	"toolcrate": [
		{"skin": preload("res://assets/sprites/shop/guns/blasterG.png"), "rarity": "e8c213"},
		{"skin": preload("res://assets/sprites/shop/guns/blasterH.png"), "rarity": "e81313"},
		{"skin": preload("res://assets/sprites/shop/guns/blasterQ.png"), "rarity": "e81313"},
		{"skin": preload("res://assets/sprites/shop/guns/blasterA.png"), "rarity": "e81313"},
		{"skin": preload("res://assets/sprites/shop/guns/blasterB.png"), "rarity": "134be8"},
		{"skin": preload("res://assets/sprites/shop/guns/blasterC.png"), "rarity": "134be8"},
		{"skin": preload("res://assets/sprites/shop/guns/blasterD.png"), "rarity": "134be8"}
	],
	"skincrate": [],
	"energybottle": [],
	"trapcrate": []
}

var panelsChildren

func _ready():
	panelsChildren = panels.get_children()

func _hideChildren():
	for child in panelsChildren:
		child.hide()

func _loadData():
	_hideChildren()
	textureRect.texture = texturesItems[item]
	
	itemName.bbcode_text = itemsNames[item]
	
	var i = 0
	
	for child in panelsChildren:
		if(i >= len(items[item])):
			break
		child.visible = true
		child.get_node("TextureRect").texture = items[item][i]['skin']
		child.get_stylebox("panel").border_color = items[item][i]['rarity']
		i += 1

func _on_AnimationPlayer_animation_started(anim_name):
	if(anim_name == "GetBig"):
		_loadData()

func _on_buy_pressed():
	parentNode.infoPanelActive = false
	parentNode._addToInventory(item)
