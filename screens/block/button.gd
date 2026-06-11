extends Button

func _ready() -> void:
	pressed.connect(_on_button_pressed)
func _on_button_pressed() -> void:
	ScreenHandler.transition_to(load("res://screens/home/home_screen.tscn"))
	print("transition")
