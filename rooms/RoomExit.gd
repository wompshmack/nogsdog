class_name RoomExit
extends Area2D
var next_room


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("energy_bar"):
		print("This seems like a player.")
		var root_node = get_node("/root/GameController")
		print(root_node)
		root_node.change_room("res://rooms/room001.tscn")
