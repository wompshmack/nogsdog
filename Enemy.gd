class_name Enemy
extends CharacterBody2D

var stats
var healthbar_bg
var healthbar_fg
var healthbar

func _ready():
	stats = Stats.new()
	create_healthbar()	

func take_damage(amount):
	stats.health -= amount
	update_healthbar()
	if stats.health <= 0:
		death()
	
func create_healthbar():
	var healthbar_script = load("res://objects/ui/healthbar.tscn")
	healthbar = healthbar_script.instantiate()
	add_child(healthbar)
	healthbar_fg = $"healthbar/healthbar_bg/healthbar_fg"
	
func update_healthbar():
	var percent_health = (stats.health / stats.max_health)
	#print("percent health :", percent_health)
	var healthbar_size_vector = Vector2(percent_health * 50,7)
	healthbar_fg.set_size(healthbar_size_vector)
	print(healthbar_fg)
	
func death():
	queue_free()
