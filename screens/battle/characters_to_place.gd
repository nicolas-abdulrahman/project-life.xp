@tool 
extends GridContainer


var lista := [preload("res://entities/persona/mago_branco/mago_branco.tres"),preload("res://entities/pets/fox/fox.tres")]
var container_model = preload("res://screens/stats/entity_hex.tscn")
func _ready() -> void:
	for item in lista:
		var container : PersonaContainer = container_model.instantiate()
		container.data = item 
		add_child(container)
	
