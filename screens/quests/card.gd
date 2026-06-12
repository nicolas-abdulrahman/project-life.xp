extends MarginContainer

@export var title: String 
@export var icon: Texture2D 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PanelContainer/MarginContainer/VBoxContainer/Label.text = title
	$PanelContainer/MarginContainer/VBoxContainer/TextureRect.texture = icon

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
