extends State
class_name StateSpecial
#This is the parent class for special moves. Dragon punch, fireball, etc.
var prelag
var postlag
var hitframe


func enter(_data = null) -> void:
	super(_data)
	print("Entered jump state")
	player.get_node("AnimatedSprite2D").animation = "idle" #TODO make a jump animation using the DP as a base
	player.velocity.y += player.JUMP_FORCE #Try to remember that jump force is a negative value so we DO want to increment this when we use it. 

func update(delta):
	horizontal_input()
	player.velocity.y += 12
	if player.velocity.y > 0:
		player.velocity.y = 0
		state_machine.change_state("StateIdle")
