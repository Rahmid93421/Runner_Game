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
	"trapcrate": preload("res://assets/sprites/shop/items/trap_crate.png"),
	"8L4573R": preload("res://assets/sprites/shop/guns/blasterG.png"),
	"8L4572R": preload("res://assets/sprites/shop/guns/blasterH.png"),
	"8L4571R": preload("res://assets/sprites/shop/guns/blasterQ.png"),
	"8L4570R": preload("res://assets/sprites/shop/guns/blasterA.png"),
	"8L4574R": preload("res://assets/sprites/shop/guns/blasterB.png"),
	"8L4575R": preload("res://assets/sprites/shop/guns/blasterC.png"),
	"8L4576R": preload("res://assets/sprites/shop/guns/blasterD.png")
}

var itemsNames = {
	"toolcrate": "[center]Tool Crate[/center]",
	"energybottle": "[center]Energy Bottle (+5 energy)[/center]",
	"8L4573R": "[center]8L4573R[/center]",
	"8L4572R": "[center]8L4572R[/center]",
	"8L4571R": "[center]8L4571R[/center]",
	"8L4570R": "[center]8L4570R[/center]",
	"8L4574R": "[center]8L4574R[/center]",
	"8L4575R": "[center]8L4575R[/center]",
	"8L4576R": "[center]8L4576R[/center]"
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
	"trapcrate": [],
	"8L4573R": [],
	"8L4572R": [],
	"8L4571R": [],
	"8L4570R": [],
	"8L4574R": [],
	"8L4575R": [],
	"8L4576R": []
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
