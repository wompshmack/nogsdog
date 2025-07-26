extends StateSpecial
class_name StateSpecialDragonpunch

var sprite_offset = Vector2(0,0)

func enter(_data = null) -> void:
	
	
	
	print("Sure you can!")
	player.sprite.animation = "dragonpunch" #TODO make a jump animation using the DP as a base
	
	#Make some kind of file for moves that it loads this data from. Hardcoded values are ugly.
	pre_lag = 12
	hit_frame = 1
	post_lag = 7
	#Use super AFTER defining the frames to determine total frames
	super(_data)

func update(delta):
	super(delta)
	if pre_lag > 0:
		player.velocity.y = -60

func exit():
		player.sprite.offset = Vector2(0,0)
		
