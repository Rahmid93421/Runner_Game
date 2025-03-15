extends Panel

export var item = ""

onready var textureRect = $TextureRect
onready var panels = $Control
onready var itemName = $RichTextLabel
onready var parentNode = get_parent().get_parent().get_parent()
onready var animationPlayer = $AnimationPlayer
onready var animationPlayer2 = $AnimationPlayer2
onready var rollBar = $Control2
onready var audioPlayer = $"../AudioStreamPlayer2D"
onready var mainAnimPlayer = $"../../AnimationPlayer"

onready var checkOut = preload("res://assets/sounds/cashier-quotka-chingquot-sound-effect-129698.mp3")

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
	if(anim_name == "OpenCaseo"):
		audioPlayer.stop()
		audioPlayer.stream = checkOut
		audioPlayer.play()
		rollBar.type = item
		rollBar._setItemsSprites()

func _on_buy_pressed():
	parentNode.infoPanelActive = false
	parentNode._addToInventory(item)
	audioPlayer.stop()
	audioPlayer.stream = checkOut
	audioPlayer.play()

func _on_Button_pressed():
	print("Buy + open")
	if(item == "toolcrate"):
		print("Play open caseo")
		parentNode.thingsReverted = false
		animationPlayer.stop(true)
		mainAnimPlayer.play("OpenCaseo")
		parentNode.startRolling = true
	if(item == "energybottle"):
		parentNode._energyBottlePopped()
	
func _playResetOpenCaseo():
	animationPlayer2.play("RevertOpenCaseo")

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "OpenCaseo"):
		print("Open animation finished")
		rollBar._rollTheBar()
	if(anim_name == "GetSmall" and parentNode.finishOpening == true):
		animationPlayer.play("RevertOpenCaseo")
		parentNode.finishOpening = false
	if(anim_name == "RevertOpenCaseo"):
		parentNode.thingsReverted = true
