extends Node2D

@onready var enemy = preload("res://enemy/enemy.tscn")
@onready var asteroid = preload("res://enemy/asteroid.tscn")

var score: int = 0
var lives:int = 3

func start_game():
	score = 0
	lives = 3
	update_labels()
	$StartScreenLayer.visible = false
	$GameLayer.visible = true
	player_ready()


func player_ready():
	%Player.reset_position()
	next_enemy_time()
	next_asteroid_time()


func player_died():
	%EnemyTimer.stop()
	%AsteroidTimer.stop()
	lives -= 1
	update_labels()
	for sprite in %SpriteList.get_children():
		sprite.queue_free()	
	if lives <= 0:
		$GameOverLayer.visible = true
		$GameOverLayer/GameOverTimer.start()
	else:
		$ReadyTimer.start()


func next_enemy_time():
	# wait randonly between 1 - 3 seconds before spawning next evemy
	%EnemyTimer.wait_time = randi_range(1,3)
	%EnemyTimer.start()


func next_asteroid_time():
	# wait randonly between 1 - 5 seconds before spawning next evemy
	%AsteroidTimer.wait_time = randi_range(1,5)
	%AsteroidTimer.start()


func update_labels():
	%ScoreLabel.text = str("Score: ", score)
	%LivesLabel.text = str("Lives: ", lives)


func _on_enemy_timer_timeout() -> void:
	for i in randi_range(1,3):
		var enemy_instance = enemy.instantiate() as Enemy
		enemy_instance.sprite_list = %SpriteList
		enemy_instance.gain_score.connect( _on_score )
		%SpriteList.add_child(enemy_instance)
	next_enemy_time()
	

func _on_asteroid_timer_timeout() -> void:
	var asteroid_instance = asteroid.instantiate() as Node2D
	%SpriteList.add_child(asteroid_instance)
	next_asteroid_time()


func _on_player_player_died() -> void:
	player_died()


func _on_ready_timer_timeout() -> void:
	player_ready()


func _on_score(points: int) -> void:
	score += points
	update_labels()
	
	
func _on_start_button_mouse_entered() -> void:
	%StartButton.modulate = Color(1,1,1,1)


func _on_start_button_mouse_exited() -> void:
	%StartButton.modulate = Color(0.49,0.49,0.49,1)


func _on_start_button_pressed() -> void:
	start_game()


func _on_game_over_timer_timeout() -> void:
	$GameLayer.visible = false
	$GameOverLayer.visible = false
	$StartScreenLayer.visible = true
