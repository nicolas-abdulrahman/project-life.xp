@tool class_name  Entity extends Control

@export var data: EntityData
@onready var sprite : Sprite2D = $Sprite2D
func _ready() -> void:
	if data:
		if data.texture:
			sprite.texture = data.texture
		if data.texture_rect.has_area():
			sprite.region_enabled = true
			sprite.region_rect = data.texture_rect 
			
			
func world_pos()-> Vector2:
	return $Sprite2D.global_position
	
