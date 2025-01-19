extends Node2D

onready var parentNode = get_parent().get_parent()
onready var lineEdit = $CanvasLayer/Panel/LineEdit

func _on_Button_pressed():
	parentNode._saveUserName(lineEdit.text)
	self.queue_free()
