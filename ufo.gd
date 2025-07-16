extends Enemy
var turn_around = 60
var turn_around_timer = turn_around
var direction = 1

const GRAVITY = 0

func _physics_process(delta):
	if turn_around_timer > 0:
		turn_around_timer -= 1
		velocity.x = 50 * direction
		
	if turn_around_timer == 0:
		turn_around_timer = turn_around
		if direction == 1:
			direction = -1
		elif direction == -1:
			direction = 1 
	velocity.y = 0
	move_and_collide(velocity * delta)
