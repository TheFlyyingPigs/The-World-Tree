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
	print("Picked up " +str(type))
	# ADD GUI INDICATION THAT THIS HAPPENED
	
