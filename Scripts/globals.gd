extends Node

# ADD ACTUAL RESOURCE TYPES!
enum ItemType {
	WATER,
	LIGHT,
	SCRAP_METAL
}

var inventory := []

func add_item(type : ItemType):
	inventory.append(type)
	

func _ready() -> void:
	randomize()
	
