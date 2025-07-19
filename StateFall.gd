extends State
class_name StateFall
var machine = self.get_parent()
func enter(_data = null) -> void:
	player.get_node("AnimatedSprite2D").animation = "idle" #TODO make a fall animation
	print("Entered falling state")

func update(delta):
	
	if player.is_on_floor():
		state_machine.change_state("StateIdle")
	
	if player.velocity.y < player.GRAVITY:
		player.velocity.y += player.GRAVITY * delta
		if player.velocity.y > player.GRAVITY:
			player.velocity.y = player.GRAVITY
	#TODO if jump switch to jump state
#	if Input.is_action_just_pressed("jump"):
#		machine.change_state("jump")
	

	#TODO if l/r input switch to run state
