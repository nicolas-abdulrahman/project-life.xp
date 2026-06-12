extends HBoxContainer

@export var color: Color = Color.WHITE:
	set(value):
		color = value
		if is_inside_tree(): # Add this check!
			_update_color()

@export var time: String = "":
	set(value):
		time = value
		if is_inside_tree():
			_update_time()

@onready var panel: PanelColor = $MarginContainer/PanelColor

func _ready():
	_update_color()
	_update_time()

func _update_color():
	if panel:
		panel.modulate = color
		panel.self_modulate = color
		print("Setting color to: ", color)  # Debug

func _update_time():
	$MarginContainer/PanelContainer/Label.text = time

func update():  # Keep for compatibility
	_update_color()
	_update_time()
