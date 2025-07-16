extends CharacterBody2D
const GRAVITY = 600
const JUMP_FORCE = -300
var poison
#player variables
var stats
var facing = 0

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
		#print(thing)
		var things_parent = thing.get_parent()
		if things_parent.has_method("CalculateVelocityModifier"):
			#print("has method!")
			number_of_velocity_mods += 1
			var modifier = things_parent.CalculateVelocityModifier()
			#Check if the character is on multiple conveyors at the same time, so the modifier won't be cumulative
			if things_parent.has_method("IsConveyor") and conveyor == 0:
				conveyor = 1
				total_modifier += modifier #TODO figure out wtf this is about
			elif things_parent.has_method("IsConveyor") and conveyor == 1:
				pass
			else:
				total_modifier += modifier

	#print(total_modifier)
	velocity = total_modifier + velocity
	if number_of_velocity_mods == 0:
		velocity = preserved_momentum + velocity
	#print("current velocity: ", velocity)
	move_and_slide()
	
	velocity -= total_modifier
	
	preserved_momentum = total_modifier
	
func take_damage(amount):
	stats.health -= amount

	
	var percent_health = (stats.health / stats.max_health)
	#print("percent health :", percent_health)
	var healthbar_size_vector = Vector2(percent_health * 50,7)
	var healthbar = get_node("Camera2D/healthbar")
	healthbar.set_size(healthbar_size_vector)
	if stats.health <= 0:
		death()
#TODO obviously make this do something
func death():
	print("you died")
	queue_free()

func _ready() -> void:

	stats = Stats.new()
	#TEST this is a test of poison, so the character just starts out poisoned
	poison = load("res://objects/status_effects/status_poison.gd").new()
	add_child(poison)

func _physics_process(delta):
	if not is_on_floor() and velocity.y < GRAVITY:
		velocity.y += GRAVITY * delta  # Apply gravity only when not grounded

	if is_on_floor():
		velocity.y = 0

	# very basic jump
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_FORCE
	# left right movement
	var lr_input = Input.get_axis("ui_left","ui_right")
	if lr_input != 0:
		if $AnimatedSprite2D.animation == "idle":
			$AnimatedSprite2D.animation = "walk"
		
		if lr_input < 0:
			$AnimatedSprite2D.flip_h = 1
			facing = 1
		if lr_input > 0:
			$AnimatedSprite2D.flip_h = 0
			facing = 0
		if velocity.x > -stats.max_run_speed and velocity.x < stats.max_run_speed:
			velocity.x += lr_input * 5
			#Apply a speed limit here so it will only be checked if they were below the speed limit
			if velocity.x > stats.max_run_speed:
				velocity.x = stats.max_run_speed
			if velocity.x < -stats.max_run_speed:
				velocity.x = -stats.max_run_speed
	if lr_input == 0:
		if $AnimatedSprite2D.animation == "walk":
			$AnimatedSprite2D.animation = "idle"
		
	#Decay of momentum
	if velocity.x > 0 and lr_input < 1:
		velocity.x -= 3
		if velocity.x < 0:
			velocity.x = 0
	if velocity.x < 0 and lr_input > -1:
		velocity.x += 3
		if velocity.x > 0:
			velocity.x = 0

	#Run status effects
	for child in get_children():
		if child.has_method("CycleStatus"):
			child.CycleStatus()
	
	#print("current health :", stats.health)
	#print("max health :", stats.max_health)

	#print(velocity.x)
	if Input.is_action_just_pressed("fireball"):
		print("pew pew")
		var new_fireball = load("res://objects/projectiles/fireball.tscn")
		var fireball_instance = new_fireball.instantiate()
		print(fireball_instance)

		fireball_instance.set_stats(2,80,self)
		
		owner.add_child(fireball_instance)

		
	#We're going to get velocity modifiers before we move, and remove them afterwards, so they don't stack.
	get_velocity_mods()
	
