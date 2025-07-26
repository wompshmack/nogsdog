class_name StateSpecialFireball
extends StateSpecial


var sprite_offset = Vector2(0,0)

func enter(_data = null) -> void:
	
	
	#TODO Fireball comes out in the wrong spot
	print("Hadoken (I don't have a joke for this)")
	
	
	#Make some kind of file for moves that it loads this data from. Hardcoded values are ugly.
	pre_lag = 12
	hit_frame = 1
	post_lag = 7
	#Use super AFTER defining the frames to determine total frames
	super(_data)

func update(delta):
	super(delta)
	if pre_lag <= 0 and hit_frame == 1:
		hit_frame = 0
		fireball()
	if post_lag == 0:
		state_machine.change_state("StateIdle")

func exit():
		player.sprite.offset = Vector2(0,0)
		

func fireball():
	print("pew pew")
	var new_fireball = load("res://objects/projectiles/fireball.tscn")
	var fireball_instance = new_fireball.instantiate()
	print(fireball_instance)
	fireball_instance.set_stats(2,80,player)
	owner.add_child(fireball_instance)
	
