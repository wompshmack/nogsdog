extends Area2D

var duration = 0.0
var speed = 0.0
var creator
var direction = 1
	
func _process(delta: float) -> void:
	position.x += speed * direction * delta
	if duration < 0:
		queue_free()
	if duration > 0:
		duration -= delta
	
func set_stats(dur,spe,cre):
	duration = dur
	speed = spe
	creator = cre
	position.x = creator.position.x
	position.y = creator.position.y
	if creator.facing == 1:
		position.x -= 11
		direction = -1
		#facing left
		$AnimatedSprite2D.flip_h = 1
		var flipped_hitbox:Vector2
		flipped_hitbox.x = -11
		$CollisionShape2D.translate(flipped_hitbox)

		#facing right
		


func _on_body_entered(body: Node2D) -> void:
	if body == creator:
		return
	if body.has_method("take_damage"):
		body.take_damage(25)
	queue_free()
