class_name Player
extends CharacterBody2D
const GRAVITY = 600
const JUMP_FORCE = -300
var stats: Stats
var facing = 0
var input_buffer
var state_machine
var sprite
var healthbar
var energybar
var torch


#This is part of the conveyor stuff
var preserved_momentum:Vector2
#This depends on the thing modifying our velocity having an Area2D which we're overlapping, because it looks for the parent of that area. 
#This is probably fine, because I can't imagine how else it would happen, but if it needs to we can simply add an additional if statement
#to check for the method, if not found check for the method on parent.
func get_velocity_mods():
	
	var number_of_velocity_mods = 0
	var conveyor = 0
	var total_modifier:Vector2
	var potential_velocity_modifiers = $feets.get_overlapping_areas()

	
	for thing in potential_velocity_modifiers:
		total_modifier = Vector2(0,0)
		var things_parent = thing.get_parent()
		if things_parent.has_method("CalculateVelocityModifier"):
			number_of_velocity_mods += 1
			var modifier = things_parent.CalculateVelocityModifier()
			#Check if the character is on multiple conveyors at the same time, so the modifier won't be cumulative
			if things_parent.has_method("IsConveyor") and conveyor == 0:
				conveyor = 1
				total_modifier += modifier
			elif things_parent.has_method("IsConveyor") and conveyor == 1:
				pass
			else:
				total_modifier += modifier

	velocity = total_modifier + velocity
	if number_of_velocity_mods == 0:
		velocity = preserved_momentum + velocity
	#print("current velocity: ", velocity)
	move_and_slide()
	velocity -= total_modifier
	preserved_momentum = total_modifier
	
#TODO obviously make this do something
func death():
	print("you died")
	queue_free()

func _ready() -> void:

	stats = Stats.new()
	input_buffer = InputBuffer.new()
	healthbar = get_node("../Camera2D/ui_bg/healthbar")
	energybar = get_node("../Camera2D/ui_bg/energybar")
	take_damage(0) #Take 0 damage to line up the healthbar
	print("ready")
	sprite = $AnimatedSprite2D
	
	state_machine = $StateMachine
	state_machine.startup()
	print("State Machine:", state_machine)
	
	torch = $torch
	
	
func _physics_process(delta): #TODO Move everything we can into _process instead of physics to save flops
	
	energy_bar()
	state_machine.run_state(delta)

	for child in get_children():
		if child.has_method("CycleStatus"):
			child.CycleStatus()
	
	if input_buffer:
		input_buffer.get_held_directions(delta,self)
	
	#We're going to get velocity modifiers before we move, and remove them afterwards, so they don't stack.
	get_velocity_mods()

func take_damage(amount):
	stats.current_health -= amount
	#We could probably modularize the healthbar setup like we do for enemies
	var percent_health = (stats.current_health / stats.max_health)
	#print("percent health :", percent_health)
	var healthbar_size_vector = Vector2(percent_health * 50,7)
	
	healthbar.set_size(healthbar_size_vector)
	if stats.current_health <= 0:
		death()
	
func energy_bar():
	if stats.current_energy < stats.max_energy and is_on_floor():
		stats.current_energy += 0.45
		var percent_energy = (stats.current_energy / stats.max_energy)
		var energybar_size_vector = Vector2(percent_energy * 50,7)
		energybar.set_size(energybar_size_vector)

func teleport(newcoords):
	print("Player position before teleport", position)
	position = newcoords
	print("Player position after teleport", position)
	
func torch_toggle():
	if torch:
		if torch.visible == true:
			torch.visible = false
		elif torch.visible == false:
			torch.visible = true
			
			
