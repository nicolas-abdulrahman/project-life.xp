extends TextureButton



@onready var original_scale: Vector2 = scale

func _ready() -> void:
	# 1. Set the pivot point to the center so it shrinks inward, not from the top-left
	pivot_offset = size / 2.0
	
	# 2. Connect the built-in button signals to our custom animation functions
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)

func _on_button_down() -> void:
	# Shrink to 95% size and darken it slightly
	scale = original_scale * 0.95
	self_modulate = Color(0.8, 0.8, 0.8) # Subtle gray overlay


func _on_button_up():
	scale = original_scale
	self_modulate = Color(1, 1, 1)
	var current_scene_root : Combat = get_tree().current_scene
	current_scene_root.Play.emit()
	print("play press")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
