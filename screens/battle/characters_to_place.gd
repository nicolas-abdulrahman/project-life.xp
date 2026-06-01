@tool 
extends GridContainer


var lista := [preload("res://assets/sprites/persona/mago_branco.png"),preload("res://assets/sprites/pets/fox.png")]
var container_model = preload("res://screens/stats/persona.tscn")
func _ready() -> void:
	for item in lista:
		var container : PersonaContainer = container_model.instantiate()
		container.texture = item
		add_child(container)
	
