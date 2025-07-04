extends CharacterBody2D

func _ready() -> void:
	# start at random position on top of viewport
	global_position.y = 0
	global_position.x = randi_range(0,480)
	# head directly to bottom but not quite straight, set angle
	# a litle to left or right
	rotate( deg_to_rad(randi_range(80,100)) )
	# start sprite turned randomly so they look diff as they spawn
	$Sprite2D.rotation_degrees = randi_range(0,359)
	
	
func _physics_process(delta: float) -> void:
	# make asteroid sprite spin on its own axis so it looks like
	# asteroid is tumbling through space
	$Sprite2D.rotation_degrees += 60 * delta
	# move asteroid in its direction of travel
	velocity = Vector2.from_angle(rotation) * 200
	move_and_slide()
