extends State
class_name StateRun
var percent_of_max_speed


func enter(_data = null) -> void:
	#Sprite stuff
	player.sprite.animation = "run"
	player.sprite.play()
	print("Entered run state")
func update(delta):
	
	horizontal_input()
	#Change animation speed to match velocity
	mod_sprite_speed()
		
	#if jump switch to jump state
	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("StateJump")
		return
	# if we walk off an edge start falling, the check for jump makes jumping not transition to falling instantly 
	if not Input.is_action_just_pressed("jump") and not player.is_on_floor():
		state_machine.change_state("StateFall")
	# If we don't have horizontal momentum switch to idle
	if player.velocity.x == 0:
		state_machine.change_state("StateIdle")
	if Input.is_action_pressed("block") and player.is_on_floor():
		state_machine.change_state("StateBlock")
	
func exit():
		player.sprite.speed_scale = 1

func mod_sprite_speed():
	if player.velocity.x > 0:
		percent_of_max_speed =  player.velocity.x / player.stats.max_run_speed
	if player.velocity.x < 0:
		percent_of_max_speed = player.velocity.x / -player.stats.max_run_speed
	player.sprite.speed_scale = percent_of_max_speed
