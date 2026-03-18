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
		"icon":preload("res://Assets/Textures/GUI/spr_TimerProgressBar.png"), # TODO ADD REAL ICONS!
		"type":EffectTypes.ALTERING
	},
	"SLOW":{
		"icon":preload("res://Assets/Textures/GUI/spr_TimerProgressBar.png"),
		"type":EffectTypes.ALTERING
	}
}

enum EffectTypes{
	INSTANT, #TAKES EFFECT INSTANTLY, NO TIMER
	ALTERING  #CHANGES A VARIABLE UNTIL THE TIMER TIMES OUT
}

var active_effects := []

func scene_switched():
	effects_manager = get_tree().get_first_node_in_group("effects_manager")

func apply_effect(effect : Effects, time:int):
	effects_manager.apply_effect(effect,time)
