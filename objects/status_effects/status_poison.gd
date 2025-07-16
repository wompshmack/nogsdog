extends Node

var duration = 600
var frequency = 15
var frequency_counter = frequency
var damage = 1
var damage_dealt = 0
func CycleStatus():
	damage_dealt = 0
	if duration <= 0:
		queue_free()
	else:
		duration -= 1
	if frequency_counter > 0:
		frequency_counter -= 1
	if frequency_counter == 0:
		frequency_counter = frequency
		damage_dealt = damage
		
	var parent = get_parent()
	parent.take_damage(damage_dealt)
