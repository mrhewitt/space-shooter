extends Area2D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# move project towards top of screen 
	position.y -= 180 * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_hit"):
		body.take_hit()
	queue_free()


# if it has gone off the top remove it
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
