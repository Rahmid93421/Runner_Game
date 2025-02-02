extends Control

onready var items = [
	$Panel, $Panel2, $Panel3, $Panel4, $Panel5, $Panel6, $Panel9
]

onready var origItems = [
	$Panel, $Panel2, $Panel3, $Panel4, $Panel5, $Panel6, $Panel9
]

onready var origPositions = [
	$Panel.rect_position, $Panel2.rect_position, $Panel3.rect_position,
	$Panel4.rect_position, $Panel5.rect_position, $Panel6.rect_position,
	$Panel9.rect_position
]

onready var shuffledItems = []

onready var rng = RandomNumberGenerator.new()

var tailItem = null
var startRolling = false
var expSpeed = 10
var decreaseSpeed = 1
var finishedRolling = false
var speed = 0
var goodItem = null

func _ready():
	tailItem = items[len(items)-1]

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
				print(goodItem)

func _rng_number_params(minimum, maximum):
	rng.randomize()
	return rng.randi_range(minimum, maximum)

func _revertItems():
	items = origItems
	var i = 0
	for item in items:
		item.rect_position = origPositions[i]
		i+=1
		
func _rollTheBar():
	startRolling = true
	goodItem = null
	speed = 27 + _rng_number_params(-5, 5)
	expSpeed = speed + _rng_number_params(-5, 5)
