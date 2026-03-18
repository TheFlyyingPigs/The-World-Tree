class_name EffectIcon extends TextureProgressBar
'
contains the visuals of a status effect, and whether or not its
'

@export var effect_id : StatusEffects.Effects
var effect : Dictionary
var time := 30 # in seconds

signal effect_timeout(effect)

@onready var timer: Timer = $Timer


func set_up():
	'
	sets up everything when node spawns
	'
	effect = StatusEffects.EffectAttributes[StatusEffects.Effects.keys()[effect_id]]
	self.texture_under = effect.icon
	timer.wait_time = time
	self.max_value = time
	timer.start()


func _on_timer_timeout() -> void:
	'
	deletes effect and sends signal when timer ends
	'
	effect_timeout.emit(effect_id)
	queue_free()

func _process(_delta: float) -> void:
	'
	sets progress bar value to time left
	'
	self.value = timer.time_left
