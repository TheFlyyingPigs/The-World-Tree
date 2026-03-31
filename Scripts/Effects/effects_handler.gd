extends Node
'
global script to pass on functions to the effect manager
'

@onready var effects_manager

enum Effects{
	POISON,
	SLOW,
	# TODO ADD ACTUAL EFFECTS
}

const EffectAttributes = {
	"POISON":{
		"icon":preload("res://Assets/Textures/GUI/effect-poison-icon.png"),
		"type":EffectTypes.ALTERING
	},
	"SLOW":{
		"icon":preload("res://Assets/Textures/GUI/effect-slow-icon.png"),
		"type":EffectTypes.ALTERING
	}
}

enum EffectTypes{
	INSTANT, #TAKES EFFECT INSTANTLY, NO TIMER
	ALTERING  #CHANGES A VARIABLE UNTIL THE TIMER TIMES OUT
}

var active_effects := []

# ALTERING VARIABLES
var is_posioned := false
var is_slowed := false

# STATUS EFFECT VARIABLES AND CONSTANTS
const poison_damage = 1 # AMOUNT OF SECONDS THAT IS ADDTIONALY TAKEN OFF THE TIMER EVERY TICK WHEN POSIONED
# IF YOU'RE POISONED TWICE, SHOULD YOU TAKE DOUBLE POISON DAMAGE?
var final_poison_damage := 0

func _process(_delta: float) -> void:
	if active_effects.has(Effects.POISON):
		is_posioned = true
	else:
		is_posioned = false
	final_poison_damage = StatusEffects.poison_damage * StatusEffects.active_effects.count(StatusEffects.Effects.POISON)
	
	if active_effects.has(Effects.SLOW):
		is_slowed = true
	else:
		is_slowed = false
	

func scene_switched():
	active_effects.clear()
	effects_manager = get_tree().get_first_node_in_group("effects_manager")

func apply_effect(effect : Effects, time:int):
	effects_manager.apply_effect(effect,time)
