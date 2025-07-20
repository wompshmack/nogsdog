extends State
class_name StateBlock

func enter(_data = null) -> void:
	player.sprite.animation = "block" 
	player.sprite.play()
	print("Entered blocking state")

func update(delta):
	
	#Check if we hit the ground 
	#print(player.sprite.frame)
	if player.sprite.frame == 21:
		player.sprite.frame = 5
		player.sprite.play()
	
	#reduce horizontal velocity sharply()
	if player.velocity.x != 0:
		player.velocity.x = player.velocity.x * 0.75
		if player.velocity.x > -1 and player.velocity.x < 1:
			player.velocity.x = 0
	
	
	if not Input.is_action_pressed("block"):
		state_machine.change_state("StateIdle")
