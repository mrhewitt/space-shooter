extends CharacterBody2D
class_name Enemy

signal gain_score 

@onready var explosion = preload("res://effects/explosion.tscn")

@export var sprite_list: Node   

func _ready() -> void:
	# start on random position along top
	global_position.y = 0
	global_position.x = randi_range(0,480)
	
	# if we on left side, angle direction of travel to right
	# else if on right angle to left
	if ( global_position.x < 240 ):
		rotate( deg_to_rad(randi_range(10,80)) )
	else:
		rotate( deg_to_rad(randi_range(100,170)) )
	# turn sprite animation to match our direction of travel
	#$AnimatedSprite2D.rotate(rotation)
	
	# select a random enemy sprite from 1..3, so animation
	# enemy_1   or enemy_2 etc 
	$AnimatedSprite2D.play( str("enemy_",randi_range(1,3)) ) 


func _physics_process(delta: float) -> void:
	# move enemy in its direction of travel
	velocity = Vector2.from_angle(rotation) * 200
	move_and_slide();
	

func take_hit():
	var explosion_instance = explosion.instantiate() as Node2D
	explosion_instance.global_position = global_position
	get_parent().add_child(explosion_instance)
	gain_score.emit(10)
	queue_free()


# if it has gone off the screen remove it
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
