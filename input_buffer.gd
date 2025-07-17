class_name InputBuffer

var buffer = []
var held_directions := {}

const BUFFER_TIME = 0.4

func get_held_directions():
	var currently_held = []
	for direction in ["ui_up","ui_down","ui_left","ui_right"]:
		if Input.is_action_pressed(direction):
			currently_held.append(direction)
			print(currently_held)
