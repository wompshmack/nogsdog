class_name InputBuffer

var buffer = []
var held_directions := {}
var previous_buffer_input
var delta_time = 0.0


var player

const BUFFER_TIME = 1.3

###############
#MOVES# #Eventually have these loaded from a file or something? idk.
##############
var moves_dragonpunch = [6,5,2,3]
var moves_fireball = [2,3,6]
var moves_dash = [5,6,5,6]

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

	# SOCD Scrubbing
	if left and right:
		left = false
		right = false
	if up and down:
		up = false
		down = false
	
	# Convert to SF style notation.
	# 7 8 9 #
	# 4 5 6 #
	# 1 2 3 #
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
	
	add_to_buffer(kp_dir)

# TODO Something isn't right with timing and I keep getting moves registering overlapping each other.
func show_me_your_moves():
	if buffer.size() >= 4:
		var last4 = [buffer[-4].input,buffer[-3].input, buffer[-2].input, buffer[-1].input]
		var last3 = [buffer[-3].input, buffer[-2].input, buffer[-1].input]
		if last4 == moves_dragonpunch:
			print("dragonpunch")
		if last3 == moves_fireball:
			print("fireball")
		if last4 == moves_dash:
			print("dash!")
			player.dash()
			
