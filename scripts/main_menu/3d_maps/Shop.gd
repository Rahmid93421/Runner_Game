extends Node2D

onready var toolsPanelAnimNode = $CanvasLayer/ToolsPanel/CanvasLayer/AnimationPlayer

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	toolsPanelAnimNode.play("ToolsIn")
