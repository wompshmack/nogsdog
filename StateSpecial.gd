extends State
class_name StateSpecial
#This is the parent class for special moves. Dragon punch, fireball, etc.

var pre_lag = 0
var post_lag = 0
var hit_frame = 0
var total_frames = 0
var current_frame = 0
var energy_cost

func enter(_data = null) -> void:
	super(_data)
	print("Check me out Stevie Imma try something")
	#Now check if we have enough energy for this move
	if player.stats.current_energy < energy_cost:
		state_machine.change_state("StateIdle")
	else:
		player.stats.current_energy -= energy_cost
		
	total_frames = pre_lag + post_lag + hit_frame

func update(delta):
	if pre_lag > 0:
		pre_lag -= 1
		current_frame += 1
		decay_momentum(0)
	elif hit_frame > 0:
		#Make a hitbox
		current_frame += 1
		hit_frame -= 1
	elif post_lag > 0:
		current_frame += 1
		post_lag -= 1
		#Cancel into special?
	else:
		state_machine.change_state("StateIdle")
		#Always set current frame to zero on exit
		current_frame = 0
	player.sprite.frame = current_frame

	
