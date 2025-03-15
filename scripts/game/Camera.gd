extends Camera

onready var playerAnimation = $character_anims/AnimationPlayer
onready var playerNode = $character_anims
onready var animationPlayer = $"../../AnimationPlayer"
onready var animationPlayer2 = $"../../AnimationPlayer2"
onready var gameWorldNode = get_parent().get_parent()

export var movePlayer = 0.0
export var jumpPlayerY = -0.35
export var rotationPlayerX = 0

var touch_start_position = Vector2()
var swipe_threshold = 100
var jumpFinished = true
var playerLane = "center"
var turningLane = false
var playOutro = false
var moveSpeed = 2

func _ready():
	playerAnimation.connect("animation_finished", self, "_on_model_animation_finished")
	
	playerAnimation.get_animation("Root|mixamocom|Layer0").loop = true
	playerAnimation.play("Root|mixamocom|Layer0")

func _process(delta):
	if(gameWorldNode.gameOver == false):
		self.position.z += moveSpeed * delta
		playerNode.position.x = movePlayer
		playerNode.position.y = jumpPlayerY
		playerNode.rotation_degrees.x = rotationPlayerX
	else:
		if(playOutro == false):
			animationPlayer.stop()
			if(jumpFinished == true):
				playerAnimation.play("Root|mixamocom|Layer0001_Root_Root")
			else:
				playerAnimation.play("Root|mixamocom|Layer0_Root001_Root")
			playerAnimation.playback_speed = 0.6
			playOutro = true

func _on_model_animation_finished(anim_name):
	if(anim_name == "Root|mixamocom|Layer0001"): # check if jump is finished
		jumpFinished = true
		playerAnimation.play("Root|mixamocom|Layer0")
	if(anim_name == "Root|mixamocom|Layer0001_Root_Root" || anim_name == "Root|mixamocom|Layer0_Root001_Root"):
		animationPlayer.play("Outro")
		playerAnimation.playback_speed = 1

func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			touch_start_position = event.position
		else: 
			_handle_swipe(event.position)
			
func _handle_swipe(end_position):
	var swipe_vector = end_position - touch_start_position

	if(abs(swipe_vector.x) > swipe_threshold and abs(swipe_vector.x) > abs(swipe_vector.y)):
		if(swipe_vector.x > 0):
			_on_swipe_right()
		else:
			_on_swipe_left()
	else:
		if(abs(swipe_vector.y) > swipe_threshold and abs(swipe_vector.y) > abs(swipe_vector.x)):
			_on_swipe_up()

func _on_swipe_right():
	if(turningLane == false):
		if(playerLane == "center"):
			animationPlayer.play("GoRight")
			playerLane = "right"
			turningLane = true
		if(playerLane == "left"):
			animationPlayer.play("GoRightFromLeft")
			playerLane = "center"
			turningLane = true
		gameWorldNode._laneChanged(playerLane)

func _on_swipe_left():
	if(turningLane == false):
		if(playerLane == "center"):
			animationPlayer.play("GoLeft")
			playerLane = "left"
			turningLane = true
		if(playerLane == "right"):
			animationPlayer.play("GoLeftFromRight")
			playerLane = "center"
			turningLane = true
		gameWorldNode._laneChanged(playerLane)

func _on_swipe_up():
	if(jumpFinished == true):
		jumpFinished = false
		playerAnimation.stop()
		animationPlayer2.play("Jump")
		playerAnimation.play("Root|mixamocom|Layer0001")

func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "GoLeftFromRight" || anim_name == "GoLeft" || anim_name == "GoRight" || anim_name == "GoRightFromLeft"):
		turningLane = false
	if(anim_name == "Outro"):
		gameWorldNode._load_actual_main_menu()
