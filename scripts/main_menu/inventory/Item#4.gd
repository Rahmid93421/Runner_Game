extends Panel

export var item = ""

onready var animNodeInfoPanel = $"../../InfoPanel/AnimationPlayer"
onready var parentNode = get_parent().get_parent().get_parent().get_parent()
onready var infoPanel = $"../../InfoPanel"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Item_mouse_entered():
	parentNode.infoPanelActive = true
	infoPanel.item = item
	animNodeInfoPanel.play("GetBig")
