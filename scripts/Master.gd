extends Node

onready var mainMenuNode = preload("res://scenes/main_menu/MainMenu.tscn")
onready var gameWorldNode = preload("res://scenes/game/GameWorld.tscn")
onready var shopNode = preload("res://scenes/main_menu/Shop.tscn")
onready var yodoNode = $Yodo1Mas
onready var yodoInitialized = false
onready var audioPlayer = $AudioStreamPlayer

var dataDict = {
	7: "powerlevel: 0", # fake powerlevel
	1: 0, # real coins
	2: "Unnamed", # username
	5: "coins: 0", # fake coins value
	3: {"toolcrate": 0, "skincrate": 0, "trapcrate": 0, "energybottle": 0, "skins": [], "weapons": [] }, # inventory, weapons: [["name", "durability", "value"]]
	4: 0, # powerlevel
	6: "skins: {}", # fake skins value
	8: 5
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

func _saveToFile():
	var file = File.new();
	file.open(saveGamePath, File.WRITE);
	file.store_var(dataDict);
	file.close();
	
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
	
func _getEnergy():
	return dataDict[8]
	
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

func _load_game():
	if(_checkEnergy() > 0 && _checkEnergy() <= maxEnergy):
		_energyDecrease()
		var instance = gameWorldNode.instance()
		self.add_child(instance)
	else:
		if(_checkEnergy() > maxEnergy):
			$RichTextLabel.visible = true

func _load_shop():
	var instance = shopNode.instance()
	self.add_child(instance)

func _yodo_status():
	return yodoInitialized

func _play_audio_menu():
	audioPlayer.play()

func _yodo_load_banner():
	yodoNode.load_banner_ad("AdaptiveBanner", "RIGHT", "BOTTOM")
	
func _yodo_show_banner():
	yodoNode.show_banner_ad()
