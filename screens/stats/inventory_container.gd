extends VBoxContainer

var inventory : Inventory 
@onready var crystals: Price = $GridContainer/Crystals
@onready var chips: Price = $GridContainer/Chips
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if inventory:
		initialize(inventory)

func initialize(d: Inventory):
	inventory = d
	crystals.price = inventory.crystals
	chips.price = inventory.chips
