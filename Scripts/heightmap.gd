extends CollisionShape3D

@export var heightmap_texture : Texture
var heightmap_image

var height_min = 0.0
var height_max = 100.0

func _ready() -> void:
	heightmap_image = heightmap_texture.get_image()
	heightmap_image.convert(Image.FORMAT_RF)
	shape.update_map_data_from_image(heightmap_image, height_min, height_max)
