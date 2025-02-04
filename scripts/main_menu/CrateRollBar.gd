extends Control

onready var items = [
	$Panel, $Panel2, $Panel3, $Panel4, $Panel5, $Panel6, $Panel9
]

onready var textureRect = [
	$Panel/TextureRect, $Panel2/TextureRect, $Panel3/TextureRect, $Panel4/TextureRect, $Panel5/TextureRect, $Panel6/TextureRect, $Panel9/TextureRect
]

onready var origItems = [
	$Panel, $Panel2, $Panel3, $Panel4, $Panel5, $Panel6, $Panel9
]

onready var origPositions = [
	$Panel.rect_position, $Panel2.rect_position, $Panel3.rect_position,
	$Panel4.rect_position, $Panel5.rect_position, $Panel6.rect_position,
	$Panel9.rect_position
]

onready var textures = {
	"toolcrate": [
		{"skin": preload("res://assets/sprites/shop/guns/blasterG.png"), "name": "8L4573R"},
		{"skin": preload("res://assets/sprites/shop/guns/blasterH.png"), "name": "8L4572R"},
		{"skin": preload("res://assets/sprites/shop/guns/blasterQ.png"), "name": "8L4571R"},
		{"skin": preload("res://assets/sprites/shop/guns/blasterA.png"), "name": "8L4570R"},
		{"skin": preload("res://assets/sprites/shop/guns/blasterB.png"), "name": "8L4574R"},
		{"skin": preload("res://assets/sprites/shop/guns/blasterC.png"), "name": "8L4575R"},
		{"skin": preload("res://assets/sprites/shop/guns/blasterD.png"), "name": "8L4576R"}
	],
	"energybottle": []
}

onready var shuffledItems = []
onready var rng = RandomNumberGenerator.new()
onready var shopParent = get_parent().get_parent().get_parent().get_parent()

var tailItem = null
var startRolling = false
var expSpeed = 10
var decreaseSpeed = 1
var finishedRolling = false
var speed = 0
var goodItem = null

var type = null
var lastType = null

func _ready():
	tailItem = items[len(items)-1]
	
#	_setItemsSprites()

func _process(delta):
	if(startRolling == true):
		if(expSpeed > 0):
			if(items[0].rect_position.x <= -40):
				items[0].hide()
				items[0].rect_position.x = items[len(items)-1].rect_position.x + 105
				items[0].visible = true
				items.append(items.pop_front())
					
			for item in items:
				item.rect_position.x -= speed*delta + expSpeed
				if(finishedRolling):
					var ColorRectPos = $ColorRect.rect_position
					if(ColorRectPos.x >= item.rect_position.x && ColorRectPos.x <= item.rect_position.x + item.rect_size.x):
						goodItem = item
			
			if(finishedRolling && goodItem == null):
				expSpeed += 1
				finishedRolling = false
				
			if(expSpeed >= speed * 2):
				decreaseSpeed = 1
			if(decreaseSpeed == 1 and expSpeed > 0):
				expSpeed -= 10 * delta
			else:
				if(decreaseSpeed == 0):
					expSpeed += 10 * delta
			if(expSpeed - 10 * delta <= 0):
				finishedRolling = true
		else:
			if(finishedRolling == true):
				startRolling = false
				finishedRolling = false
				expSpeed = 10
				decreaseSpeed = 1
				$"../Button3".disabled = false
				$"../Button4".visible = true
				print(goodItem.name)
				shopParent._saveOpenedItem(goodItem.name)

func _rng_number_params(minimum, maximum):
	rng.randomize()
	return rng.randi_range(minimum, maximum)

func _revertItems():
	items = origItems
	var i = 0
	for item in items:
		item.rect_position = origPositions[i]
		i+=1
		
func _setItemsSprites():
	_revertItems()
	if(type != lastType):
		$"../AnimationPlayer".play("RevertOpenCaseo")
		if(len(textures[type]) != 0):
			for i in range(0, len(textures[type])):
				textureRect[i].texture = textures[type][i]['skin']
				items[i].name = textures[type][i]['name']
		else:
			pass
	lastType = type

func _rollTheBar():
	if(type == "toolcrate"):
		startRolling = true
		goodItem = null
		speed = 40 + _rng_number_params(-5, 5)
		expSpeed = speed + _rng_number_params(-5, 5)
