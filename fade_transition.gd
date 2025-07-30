extends ColorRect

func _process(delta: float) -> void:
	
	if color.a > 0:
		color.a -= 0.01

func refresh():
	color.a = 1
