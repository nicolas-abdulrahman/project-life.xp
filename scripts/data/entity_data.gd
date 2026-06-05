class_name EntityData extends Resource


enum EntityType {Persona, Pet, Enemy}
@export var character_name: String = ""
@export var max_health: int = 5
@export var entity_type: EntityType = EntityType.Persona 
@export var animation_library: AnimationLibrary
@export var texture : Texture2D
@export var texture_rect : Rect2i 
