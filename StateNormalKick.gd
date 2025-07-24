class_name StateNormalKick
extends StateNormal
var sprite_offset = Vector2(32,0)

func enter(_data = null) -> void:
	
	#Offset sprite for the doublewide sprite we used. This is probably a terrible way to do this, implement something better later TODO
	if player.sprite.flip_h == false:
		player.sprite.offset = sprite_offset
	if player.sprite.flip_h == true:
		player.sprite.offset = -sprite_offset
	
	
	print("Doing a kick!")
	player.sprite.animation = "kick" #TODO make a jump animation using the DP as a base
	
	#Make some kind of file for moves that it loads this data from. Hardcoded values are ugly.
	pre_lag = 12
	hit_frame = 1
	post_lag = 7
	#Use super AFTER defining the frames to determine total frames
	super(_data)

func update(delta):
	super(delta)

func exit():
		player.sprite.offset = Vector2(0,0)
		
