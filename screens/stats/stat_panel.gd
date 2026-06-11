@tool 
class_name StatPanel
extends Control


@export var stat_name = "Vitality"
@export var icon = "res://assets/svg/icons/g23.svg"


@onready var barChart := $PanelContainer/HSplitContainer/MarginContainer2/BarChart
@onready var hbox := $PanelContainer/HSplitContainer/MarginContainer2/BarChart/HBoxContainer
@onready var stat := $PanelContainer/HSplitContainer/MarginContainer/VBoxContainer/Name
@onready var level := $PanelContainer/HSplitContainer/MarginContainer/VBoxContainer/Level
var data := [1, 5,2,4,7,6, 10]

func setup(stat, level):
	stat.text= stat
	level.name = level
func _ready() -> void:
	const template := preload("res://screens/stats/box_label.tscn")
	var day_labels: Array[String] = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]
	for i in range(7):
		var new_node=template.instantiate() 
		var label = new_node.get_child(1)
		label.text = day_labels[i] 
		hbox.add_child(new_node)

		

		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass
