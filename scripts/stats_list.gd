extends VBoxContainer

var svg = "res://assets/svg/stats_border.svg"
var texture
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(3):
		texture = TextureRect.new()
		texture.texture = load(svg)
		add_element(texture)
	pass # Replace with function body.

func add_element(texture):
	add_child(texture)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
