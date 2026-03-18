class_name EffectIcon extends Control
'
contains the visuals of a status effect, and whether or not its
'

@export var effect : StatusEffects.Effects

@onready var icon: TextureRect = $Icon


func _ready() -> void:
	'
	sets up everything when node spawns
	'
	icon.texture = StatusEffects.EffectAttributes[effect].icon
