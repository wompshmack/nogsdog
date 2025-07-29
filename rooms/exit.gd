class_name RoomExit
extends Area2D
var 

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("energy_bar"):
		print("This seems like a player.")
		var room = get_parent()
		room.queue_free()
