extends Node

const GAME_AUDIO_BUS_LAYOUT = preload("res://audio/game_audio_bus_layout.tres")

const SFX = {
	laser = [
		preload("res://assets/audio/02_Laser_Normal_B.wav")
	],
	explosion = [
		preload("res://assets/audio/explosion_mid_1.ogg"),
		preload("res://assets/audio/explosion_small_1.ogg"),
		preload("res://assets/audio/explosion_small_2.ogg")
	]
}

func play_random( group: String ) -> void:
	var sfx_list: Array = SFX.get(group)
	if sfx_list and sfx_list.size() > 0:
		play( sfx_list.pick_random() )


func play(sound_to_player: AudioStream) -> void:
	# create a new audio player and put it in the scene
	# if you forgot to add_child() to incklude it in a scene
	# your sound will not play 
	var stream = AudioStreamPlayer2D.new()
	stream.bus = "SFX"
	add_child(stream)
	# tell it to start playing the sound we chose
	stream.stream = sound_to_player
	stream.play() 
	# wait for "finished" signal so we can know when it is done
	await stream.finished
	# delete sound player from scene so finished players dont simply continue tp pile up
	stream.queue_free()
