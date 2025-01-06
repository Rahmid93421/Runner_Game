extends Node

onready var idleNode = $Environment/idle2.get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	idleNode.get_animation("Root|Root|Root|mixamocom|Layer0").loop = true
	idleNode.play("Root|Root|Root|mixamocom|Layer0")
	
