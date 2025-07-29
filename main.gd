extends Node2D
var current_room


func _ready():
	print("main ready")
	change_room("res://rooms/starting_room.tscn")
	
	
	
func change_room(new):
	var new_room = load(new).instantiate()
	if current_room:
		current_room.queue_free()
	add_child(new_room)
	current_room = new_room
	
