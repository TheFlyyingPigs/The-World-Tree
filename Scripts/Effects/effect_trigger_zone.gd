class_name EffectTriggerZone extends Area3D

@export var zone_settings : EffectZoneSettings

@onready var collision: CollisionShape3D = $CollisionShape3D


func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		StatusEffects.apply_effect(zone_settings.effect, zone_settings.time)
