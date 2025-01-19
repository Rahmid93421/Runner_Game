extends Panel

export var item = ""

onready var textureRect = $TextureRect
onready var panels = $Control
onready var itemName = $RichTextLabel

onready var texturesItems = {
	"toolcrate": preload("res://assets/sprites/shop/items/crate.png"),
	"skincrate": preload("res://assets/sprites/shop/items/skin_crate.png"),
	"energybottle": preload("res://assets/sprites/shop/items/energy_bottle.png"),
	"trapcrate": preload("res://assets/sprites/shop/items/trap_crate.png")
}

var itemsNames = {
	"toolcrate": "[center]Tool Crate\n1000 coins[/center]",
	"energybottle": "[center]Energy Bottle (+5 energy)\n300 coins[/center]"
}

onready var items = {
	"toolcrate": [
		preload("res://assets/sprites/shop/guns/blasterG.png"),
		preload("res://assets/sprites/shop/guns/blasterH.png"),
		preload("res://assets/sprites/shop/guns/blasterQ.png"),
		preload("res://assets/sprites/shop/guns/blasterA.png"),
		preload("res://assets/sprites/shop/guns/blasterB.png"),
		preload("res://assets/sprites/shop/guns/blasterC.png"),
		preload("res://assets/sprites/shop/guns/blasterD.png")
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
		child.get_node("TextureRect").texture = items[item][i]
		
		i += 1

func _on_AnimationPlayer_animation_started(anim_name):
	if(anim_name == "GetBig"):
		_loadData()

func _on_buy_pressed():
	pass # Replace with function body.
