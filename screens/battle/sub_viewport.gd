extends SubViewport

@onready var map: Map =$GameHandler/Map
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size.y = map.HEIGHT * map.tile_set.tile_size.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
