extends State
class_name StateIdle

func enter(_data = null) -> void:
	super(_data)
	print("Entered idle state")
	player.get_node("AnimatedSprite2D").animation = "idle" #probably need some tree stuff to find the animation node

func update(delta):
	
	#TODO timer do eventually do a "bored" animation or something
	
	horizontal_input()
	# If grounded and moving switch to run state
	if player.velocity.x != 0 and player.is_on_floor():
		state_machine.change_state("StateRun")

	if not player.is_on_floor():
		state_machine.change_state("StateFall")
		
	if player.is_on_floor() and Input.is_action_just_pressed("jump"):
		state_machine.change_state("StateJump")

	if Input.is_action_pressed("block") and player.is_on_floor():
		state_machine.change_state("StateBlock")
	
	#TODO if l/r input switch to run state
