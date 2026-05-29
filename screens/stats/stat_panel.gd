@tool 
extends Control


@onready var barChart = $PanelContainer/HSplitContainer/MarginContainer2/BarChart
@onready var hbox = $PanelContainer/HSplitContainer/MarginContainer2/BarChart/HBoxContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	const template = preload("res://screens/stats/box_label.tscn")
	var day_labels: Array[String] = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
	for i in range(7):
		var new_node=template.instantiate() 
		var label = new_node.get_child(1)
		label.text = day_labels[i] 
		hbox.add_child(new_node)

		

		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
