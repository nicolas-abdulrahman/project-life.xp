@tool class_name  Entity extends Control

@export var data: EntityData
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var hitbox : CollisionShape2D = $Area2D/CollisionShape2D
@onready var area  = $Area2D
@export var flipped = false
func _ready() -> void:
	clear_animations()
	if data:
		set_data(data)
	animation.pause()
	var bus : EventBusClass = EventBus
	bus.animate.connect(animation.play)

func _on_animation_finish(anim_name: String):
	if anim_name == "Attack":
		animation.play("Idle")
		animation.seek(0, true)
		
		
		
func set_data(entity_data):
	data = entity_data
	var new_scale = Vector2(2,2)
	sprite.scale = new_scale
	area.scale = new_scale
	var folder = data.resource_path.get_base_dir()
	var sprite_sheet = folder + "/sprite_sheet.png"
	if FileAccess.file_exists(sprite_sheet):
		var animation_lib = folder + "/animation_player.res"
		var animation_library:AnimationLibrary = load(animation_lib)
		sprite.texture = load(sprite_sheet)
		sprite.hframes = data.frames.x 
		sprite.vframes = data.frames.y
		animation.add_animation_library("", animation_library)
		animation.animation_finished.connect(_on_animation_finish)
	else:
		var image = sprite_sheet + "/texture.png"
		sprite.texture = load(image)	
	if data.hitbox.has_area():
		hitbox.position = Vector2(data.hitbox.position)
		hitbox.shape = hitbox.shape.duplicate()
		hitbox.shape.size = Vector2(data.hitbox.size)

	queue_redraw()


func clear_animations():
	animation.disconnect(&"animation_finished", _on_animation_finish)
	var library_list = animation.get_animation_library_list()
	for library_name in library_list:
		animation.remove_animation_library(library_name)
func world_pos()-> Vector2:
	return $Sprite2D.global_position
	
func get_height() -> float:
	if hitbox and hitbox.shape is RectangleShape2D:
		# Multiply the raw shape height by the Area2D's vertical scale
		return hitbox.shape.size.y * area.scale.y
	return 0.0
	
func get_width() -> float:
	if hitbox and hitbox.shape is RectangleShape2D:
		# Multiply the raw shape width by the Area2D's horizontal scale
		return hitbox.shape.size.x * area.scale.x
	return 0.0
	
func play(name: String):
	animation.play(name )

func flip():
	sprite.flip_h = flipped
	
