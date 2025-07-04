extends Area2D

signal player_died
signal player_dead 

@onready var projectile = preload("res://player/projectile.tscn")
@onready var explosion = preload("res://effects/explosion.tscn")

func _ready() -> void:
	pass


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move_left"):
		position.x += -240 * delta
	elif Input.is_action_pressed("move_right"):
		position.x += 240 * delta


# fire a projectile automatically on every timer tick (default 1 second)
func _on_timer_timeout() -> void:
	var projectile_instance = projectile.instantiate() as Node2D
	projectile_instance.global_position = %Muzzle.global_position
	%SpriteList.add_child(projectile_instance)


func _on_area_entered(area: Area2D) -> void:
	pass


func reset_position():
	position.x = 240
	visible = true
	$ProjectileTimer.start()


func _on_body_entered(body: Node2D) -> void:
	var explosion_instance = explosion.instantiate() as Node2D
	explosion_instance.global_position = global_position
	get_parent().add_child(explosion_instance)
	visible = false
	$ProjectileTimer.stop()
	player_died.emit() 
