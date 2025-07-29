class_name Room
extends TileMapLayer
var player
var entrance

func _ready() -> void:
	player = get_node("/root/GameController/player")
	if entrance:
		var starting_position = entrance.position
		player.teleport(starting_position)
