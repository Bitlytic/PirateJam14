class_name CoreLight
extends CommonLight


@export var sprite : Sprite2D

var _image : Image

var _texture : ImageTexture

func _ready():
	add_to_group("lights")
