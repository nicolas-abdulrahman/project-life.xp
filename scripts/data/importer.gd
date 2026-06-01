class_name Importer extends Resource

enum Entity {Persona, Pet}

var entity = Entity.Persona
var nome = "mago_branco"

func _init(t, n):
	entity = t
	nome = n

func load_entity():
	var path =""
	match entity:
		Entity.Persona:
			path = "res://assets/sprites/persona/"
		Entity.Pet:
			path = "res://assets/sprites/pets/"
	path += nome
	var scene = load(path)
	return 	scene	
