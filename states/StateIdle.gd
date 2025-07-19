extends State
class_name StateIdle

func enter(_data = null) -> void:
	super(_data)
	print("Entered idle state")
	player.get_node("AnimatedSprite2D").animation = "idle" #probably need some tree stuff to find the animation node

func update(delta):
	
	#TODO timer do eventually do a "bored" animation or something
	
	if not player.is_on_floor():
		state_machine.change_state("StateFall")
	#TODO if jump switch to jump state
	if player.is_on_floor() and Input.is_action_just_pressed("jump"):
		state_machine.change_state("StateJump")
	
	#TODO if l/r input switch to run state
