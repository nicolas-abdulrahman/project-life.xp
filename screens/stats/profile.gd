class_name ProfileNode extends VBoxContainer

@export var data: UserData

func initialize(d: UserData):
	data = d
	%ProfilePic.texture = data.picture
	%InventoryContainer.initialize(data.inventory) 
	%UserName.text = data.user_name
	print("Profile initialized!")
func _ready() -> void:
	if data:
		initialize(data)
