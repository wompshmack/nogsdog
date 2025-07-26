class_name State
extends Node

var state_machine
var player: Player

func enter(_data = null) -> void:
	pass
	
func exit() -> void:
	pass

func horizontal_input():
	var lr_input = Input.get_axis("ui_left","ui_right")
	if player.velocity.x > -player.stats.max_run_speed and player.velocity.x < player.stats.max_run_speed:
		player.velocity.x += lr_input * 3
		
		#This just makes sure our max run speed caps out exactly
		if player.velocity.x > player.stats.max_run_speed:
			player.velocity.x = player.stats.max_run_speed
		if player.velocity.x < -player.stats.max_run_speed:
			player.velocity.x = -player.stats.max_run_speed

	decay_momentum(lr_input)
	# Sprite flippin
	if lr_input != 0:
		sprite_flip(lr_input)
		
func decay_momentum(lr_input):
	if lr_input == 0:
		player.velocity.x = player.velocity.x * 0.88
		if player.velocity.x > -1 and player.velocity.x < 1:
			player.velocity.x = 0
	
	#If pressing a direction opposed to the direction of your momentum decay momentum faster
	if (lr_input > 0 and player.velocity.x < 0) or (lr_input < 0 and player.velocity.x > 0):
		player.velocity.x = player.velocity.x * 0.88
		if player.velocity.x > -1 and player.velocity.x < 1:
			player.velocity.x = 0

func sprite_flip(lr_input):
	if lr_input > 0:
		player.sprite.flip_h = 0
		player.facing = 0
	if lr_input < 0:
		player.sprite.flip_h = 1
		player.facing = 1
