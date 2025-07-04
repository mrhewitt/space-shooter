extends Area2D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# move project towards top of screen 
	position.y -= 180 * delta
	# if it has gone off the top remove it
	if position.y < 0:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_hit"):
		body.take_hit()
	queue_free()
