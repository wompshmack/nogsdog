extends StaticBody2D
var convey_direction:Vector2
var convey_speed

func _ready() -> void:
	convey_direction.x = 1
	#convey_direction.y = 0
	convey_speed = 10
	

func CalculateVelocityModifier():
	var mod = convey_direction * convey_speed
	return mod
		
func IsConveyor():
	pass
