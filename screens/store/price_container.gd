@tool class_name Price extends Control

@export var value = 20
@onready var label =$Label2
# Called when the node enters the scene tree for the first time.
func update(v):
	value = v
	label.text =str(value)

func _ready() -> void:
	size.y = label.size.y
	custom_minimum_size.y = label.size.y
	custom_minimum_size.x = 50
	label.text =str(value)
