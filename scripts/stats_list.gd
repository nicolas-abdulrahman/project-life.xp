@tool
extends VBoxContainer

var scene = preload("res://screens/stats/stat_panel.tscn")

var nodes = ["Vitality", "Agility", "Mind", "Spirit", "Charisma" ]
func _ready() -> void:

	for i in range(6):
		var stat_element:	StatPanel = scene.instantiate()
		add_element(scene.instantiate())
func add_element(scene):
	add_child(scene)
