extends VBoxContainer

@export var data : UserData
var scene = preload("res://screens/stats/stat_panel.tscn")


func initalize(d:UserData):
	data = d
	if data.user_stats.size() == 0:
		data.initialize_new_profile()
	for stat in data.user_stats:
		var node :StatPanelNode =	scene.instantiate()
		node.data = stat
		add_child(node)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if  data:
		initalize(data)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
