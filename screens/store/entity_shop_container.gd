@tool class_name  EntityContainer extends VBoxContainer

@onready var persona: PersonaContainer = $Persona_container
@onready var label = $Price/Label2

@export var data : EntityData:
	set(value):
		data = value
		if not is_inside_tree() or get_child_count()==0:
			return
		persona.data= data
		persona.get_entity().set_data(data)
		queue_redraw()


func _ready() -> void:
	if data:
		#label.text = str(data.price)
		await persona.ready
		persona.get_entity().set_data(data)

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			print("click")
			persona.get_entity().animation.play("Idle")
	
