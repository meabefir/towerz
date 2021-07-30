extends Control

var confirmFuncRef
var denyFuncRef
var text

onready var label = get_node("NinePatchRect/Label")

func init(_text, confirm_func, object, deny_func):
	confirmFuncRef = funcref(object, confirm_func)
	if deny_func != null:
		denyFuncRef = funcref(object, deny_func)
	text = _text

func _ready():
	label.text = text

func _on_Yes_pressed():
	confirmFuncRef.call_func()
	queue_free()

func _on_No_pressed():
	if denyFuncRef != null:
		denyFuncRef.call_func()
	queue_free()
