extends Control
'
handles 
'

@onready var effect_icon = preload("res://Scenes/effect_icon.tscn")
@onready var effect_container: VBoxContainer = $EffectContainer


func apply_effect(effect:StatusEffects.Effects, time : int):
	'
	applies a new effect by adding it to the container and to the active effects array
	arguments:
		effect: the effect that should be applied
		time: the amount of time in seconds that that effect should last
	'
	if StatusEffects.EffectAttributes[StatusEffects.Effects.keys()[effect]].type != StatusEffects.EffectTypes.INSTANT:
		var new_effect :EffectIcon= effect_icon.instantiate()
		effect_container.add_child(new_effect)
		new_effect.effect_id = effect
		new_effect.time = time
		new_effect.set_up()
		
		StatusEffects.active_effects.append(effect)
		new_effect.effect_timeout.connect(stop_effect)
	
	else:
		Callable(self,str(effect)+"_instant").call()


func stop_effect(effect:StatusEffects.Effects):
	'
	stops the given effect from ticking by removing it from the active effects array
	'
	StatusEffects.active_effects.erase(effect)
