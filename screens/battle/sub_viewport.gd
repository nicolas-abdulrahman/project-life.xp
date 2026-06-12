extends SubViewport

@onready var map: Map =$GameHandler/Map
var padding = 50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size.y = map.HEIGHT * map.tile_set.tile_size.y + 50
	%GameHandler.position.y +=padding

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
