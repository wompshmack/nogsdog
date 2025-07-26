class_name InputBuffer

var buffer = []
var held_directions := {}
var previous_buffer_input
var delta_time = 0.0


var player

const BUFFER_TIME = 1.5

###############
#MOVES# #Eventually have these loaded from a file or something? idk.
##############
var moves := {
	"dragonpunch" : [[4,5,2,1,20],[6,5,2,3,20],[6,5,2,23],[5,2,5,2]],
	"fireball" : [[2,3,6,20],[2,1,4,20]],
	"dash" : [5,6,5,6]
}


func add_to_buffer(input):
	if input != previous_buffer_input:
		buffer.append({"input": input,"time": BUFFER_TIME})
		previous_buffer_input = input
	
	buffer_cleanup()		

func buffer_cleanup():
	for direction in buffer:
		direction["time"] -= delta_time
		if direction["time"] < 0:
			buffer.erase(direction)
			print(buffer)
	show_me_your_moves()

func get_held_directions(delta,caller):
	if not player:
		player = caller
		
	delta_time = delta	
	var kp_dir
	
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	var up = Input.is_action_pressed("ui_up")
	var down = Input.is_action_pressed("ui_down")
	
	var guard = Input.is_action_pressed("block")
	var punch = Input.is_action_pressed("punch")
	var kick = Input.is_action_pressed("kick")
	
	# SOCD Scrubbing
	if left and right:
		left = false
		right = false
	if up and down:
		up = false
		down = false
	
	# Convert to SF style notation.
	# 7 8 9 #
	# 4 5 6 #	G  P  K
	# 1 2 3 #   10 20 40
	
	## I used these numbers for GPK so they could be added together to do compound button inputs. Might not end up using that
	## K is 40 instead of 30 so no combination of things can ever add up to the same thing. 

	if up:
		if left:
			kp_dir = 7
		elif right:
			kp_dir = 9
		else:
			kp_dir = 8
	elif down:
		if left:
			kp_dir = 1
		elif right:
				kp_dir = 3
		else:
			kp_dir = 2
	elif left:
		kp_dir = 4
	elif right:
		kp_dir = 6
	else:
		kp_dir = 5
	
	if guard:
		kp_dir =+ 10
	if punch:
		kp_dir =+ 20
	if kick:
		kp_dir =+ 40
	
	
	add_to_buffer(kp_dir)

func show_me_your_moves():
	if buffer.size() >= 5:
		var last5 = [buffer[-5].input,buffer[-4].input,buffer[-3].input, buffer[-2].input, buffer[-1].input]
		var last4 = [buffer[-4].input,buffer[-3].input, buffer[-2].input, buffer[-1].input]
		#var last3 = [buffer[-3].input, buffer[-2].input, buffer[-1].input]
		for sequence in moves.dragonpunch:
			print(sequence)
			if sequence == last5 or sequence == last4:
				player.state_machine.special("dragonpunch")
				buffer.clear()
		for sequence in moves.fireball:
			if sequence == last5 or sequence == last4:
				player.state_machine.special("fireball")
				buffer.clear()
		#if last4 == moves_dash:
			#print("dash!")
			#player.dash()
			#buffer.clear()
			
	#Normals
	#Just put in normals after specials so specials should take priority
		
