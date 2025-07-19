extends State
class_name StateRun
var machine = self.get_parent()
func enter(_data = null) -> void:
	player.play_animation("run") #probably need some tree stuff to find the animation node

func update(delta):
		
	
	#TODO if jump switch to jump state
	if Input.is_action_just_pressed("jump"):
		machine.change_state("jump")
	

	#TODO if l/r input switch to run state
