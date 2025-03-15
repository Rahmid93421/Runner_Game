extends Node

onready var mainMenuNode = preload("res://scenes/main_menu/MainMenu.tscn")
onready var gameWorldNode = preload("res://scenes/game/GameWorld.tscn")
onready var shopNode = preload("res://scenes/main_menu/ShopPanel.tscn")
onready var inventoryNode = preload("res://scenes/main_menu/Inventory.tscn")
onready var yodoNode = $Yodo1Mas
onready var yodoInitialized = false
onready var audioPlayer = $AudioStreamPlayer
onready var actualMainMenu = preload("res://scenes/main_menu/ActualMenu.tscn")
onready var mainMenuMusic = preload("res://assets/sounds/Juhani Junkala [Retro Game Music Pack] Ending.wav")
onready var gameMusic = preload("res://assets/sounds/Juhani Junkala [Retro Game Music Pack] Title Screen.wav")
onready var animationPlayer = $AnimationPlayer

var dataDict = {
	7: "powerlevel: 0", # fake powerlevel
	1: 0, # real coins
	2: "Unnamed", # username
	5: "coins: 0", # fake coins value
	3: {"toolcrate": 0, "skincrate": 0, "trapcrate": 0, "energybottle": 0 }, # inventory, weapons: [["name", "durability", "value"]]
	20: {
			"blasters": { 
				#           L  P  I  =>   LEVEL | POWER | ITEMS
				"8L4573R": [0, 0, 0],
				"8L4572R": [0, 0, 0],
				"8L4571R": [0, 0, 0],
				"8L4570R": [0, 0, 0],
				"8L4574R": [0, 0, 0],
				"8L4575R": [0, 0, 0],
				"8L4576R": [0, 0, 0]
			},
			"skins": {
				
			}
		},
	21: "default",
	4: 0, # powerlevel
	6: "skins: {}", # fake skins value
	8: 5 # energy
}

var defaultRates = {
	# fire rate, spread, bullets number, damage
	"default": {"firerate": 1.35, "spread": 1, "bullets": 1, "damage": 30},
	"8L4573R": {"firerate": 0.65, "spread": .5, "bullets": 3, "damage": 50}, # shotgun laser
	"8L4572R": {"firerate": 0.8, "spread": 1, "bullets": 1, "damage": 135}, # bomb launcher (area damage)
	"8L4571R": {"firerate": 1.55, "spread": .5, "bullets": 6, "damage": 90}, # dual shotgun
	"8L4570R": {"firerate": .5, "spread": 1, "bullets": 1, "damage": 35}, # smg like
	"8L4574R": {"firerate": .6, "spread": 1, "bullets": 1, "damage": 25}, # smg like
	"8L4575R": {"firerate": .45, "spread": 1, "bullets": 1, "damage": 10}, # smg like
	"8L4576R": {"firerate": .95, "spread": 1, "bullets": 1, "damage": 40} # rifle
}

var saveGamePath = "user://saveGame.save";
var maxEnergy = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	print(dataDict[2])
	yodoInitialized = yodoNode.init()
	_yodo_load_banner()

func _checkIfSaveFileExists():
	var file = File.new()
	if(file.file_exists(saveGamePath)):
		return true
	return false
	
func _getRate():
	return defaultRates[dataDict[21]]

func _saveToFile():
	var file = File.new();
	file.open(saveGamePath, File.WRITE);
	file.store_var(dataDict);
	file.close();
	
func _setBlaster(item):
	dataDict[21] = item;
	_saveToFile()
	
func _tollCrateOpenedItemSave(item):
	dataDict[20]['blasters'][item][2] += 1
	_saveToFile()
	
func _getItemData():
	return dataDict[20]

func _saveToInventory(_identifier, _value):
	pass

func _saveUserName(username):
	dataDict[2] = username
	_saveToFile()
	
func _loadFromFile():
	var file = File.new()
	file.open(saveGamePath, File.READ)
	dataDict = file.get_var()
	file.close()

func _getUserName():
	return dataDict[2]

func _getCoins():
	return dataDict[1]
	
func _useEnergyBottle():
	dataDict[3]['energybottle'] -= 1
	
func _getEnergy():
	return dataDict[8]
	
func _useToolCrate():
	dataDict[3]['toolcrate'] -= 1

func _addEnergy(value):
	dataDict[8] += value
	_saveToFile()
	
func _energyDecrease():
	dataDict[8] -= 1
	_saveToFile()

func _checkEnergy():
	return dataDict[8]
	
func _getInventory():
	return dataDict[3]
	
func _incrementInventoryItem(item):
	dataDict[3][item] += 1
	_saveToFile()

func _intro_finished():
	_load_main_menu()

func _load_main_menu():
	var instance = mainMenuNode.instance()
	self.add_child(instance)

func _load_inventory():
	var instance = inventoryNode.instance()
	self.add_child(instance)

func _load_game():
	if(_checkEnergy() > 0):
		audioPlayer.stop()
		audioPlayer.stream = gameMusic
		audioPlayer.play()
		animationPlayer.play("MusicFadeIn")
		_energyDecrease()
		var instance = gameWorldNode.instance()
		self.add_child(instance)

func _load_actual_menu():
	audioPlayer.stop()
	audioPlayer.stream = mainMenuMusic
	audioPlayer.play()
	animationPlayer.play("MusicFadeIn")
	var instance = actualMainMenu.instance()
	self.add_child(instance)

func _load_shop():
	animationPlayer.play("MusicFadeIn")
	var instance = shopNode.instance()
	self.add_child(instance)

func _yodo_status():
	return yodoInitialized

func _play_audio_menu():
	audioPlayer.play()
	
func _fadeOutMusic():
	animationPlayer.play("MusicFadeOut")
	
func _fadeOutMusicMenu():
	animationPlayer.play("MusicFadeOutMenu")

func _yodo_load_banner():
	yodoNode.load_banner_ad("AdaptiveBanner", "RIGHT", "BOTTOM")
	
func _yodo_show_banner():
	yodoNode.show_banner_ad()
