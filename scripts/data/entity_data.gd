class_name EntityData extends Resource


enum EntityType {Persona, Pet, Enemy}
@export var character_name: String = ""
@export var max_health: int = 5
@export var entity_type: EntityType = EntityType.Persona 
@export var hitbox : Rect2i 
@export var frames = 5
@export var price = 50
