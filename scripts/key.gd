class_name Key extends Node2D

@export var data : Item

@onready var sprite = $Sprite2D

func _ready():
	if data:
		sprite.texture = data.texture

func set_data(data):
	if sprite:
		data=data
		sprite.texture = data.texture
