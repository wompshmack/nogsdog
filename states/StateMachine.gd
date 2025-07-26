extends Node
class_name StateMachine
#This is the actual onject that should be a child of the player object. The attatched states should be children of this.
var current_state
var player

func startup() -> void:
	player = get_parent()
	for state in get_children():
		state.state_machine = self
		state.player = player
	change_state("StateIdle")
	
func run_state(delta):
	current_state.update(delta)

func change_state(state):
	if current_state:
		current_state.exit()
	var new_state = get_node(state)
	
	current_state = new_state
	current_state.enter()
	
func special(move):
	if current_state.has_method("special"):
		if move == "fireball":
			change_state("StateSpecialFireball")
		if move == "dragonpunch":
			change_state("StateSpecialDragonpunch")

func normal(move):
	if current_state.has_method("normal"):
		if Input.is_action_just_pressed("kick"):
			change_state("StateNormalKick")
