class_name StatPanelNode
extends Control



@export var data : StatData


@onready var barChart := $PanelContainer/HSplitContainer/MarginContainer2/BarChart
@onready var hbox := $PanelContainer/HSplitContainer/MarginContainer2/BarChart/HBoxContainer
@onready var stat := $PanelContainer/HSplitContainer/MarginContainer/VBoxContainer/Name
@onready var level := $PanelContainer/HSplitContainer/MarginContainer/VBoxContainer/Level
@onready var icon = $PanelContainer/HSplitContainer/MarginContainer/VBoxContainer/TextureRect

const template := preload("res://screens/stats/box_label.tscn")
func initialize(d: StatData):
	data = d
	var s: Stat= STATS.get_resource(data.name)
	stat.text= data.name
	level.text = str(data.level)
	icon.texture = s.icon
	
func _ready() -> void:
	if data:
		initialize(data)
	var day_labels: Array[String] = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
	for i in range(7):
		var new_node=template.instantiate() 
		var label = new_node.get_child(1)
		label.text = day_labels[i] 
		hbox.add_child(new_node)
