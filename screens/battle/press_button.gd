class_name PressButton extends TextureButton



@onready var original_scale: Vector2 = scale

func _ready() -> void:
	pivot_offset = size / 2.0
	button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)

func _on_button_down() -> void:
	# Shrink to 95% size and darken it slightly
	scale = original_scale * 0.95
	self_modulate = Color(0.8, 0.8, 0.8) # Subtle gray overlay

func button_press_action():
	pass
func _on_button_up():
	scale = original_scale
	self_modulate = Color(1, 1, 1)
	button_press_action()
