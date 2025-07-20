extends State
class_name StateFall

func enter(_data = null) -> void:
	player.get_node("AnimatedSprite2D").animation = "idle" #TODO make a fall animation
	print("Entered falling state")

func update(delta):
	
	#Check if we hit the ground 
	if player.is_on_floor():
		state_machine.change_state("StateIdle")
		#if player.is_on_floor() and player.velocity.x != 0:
			#state_machine.change_state("StateRun")
				
		
	horizontal_input()
	
	#terminal velocity
	if player.velocity.y < player.GRAVITY:
		player.velocity.y += player.GRAVITY * delta
		if player.velocity.y > player.GRAVITY:
			player.velocity.y = player.GRAVITY
