extends Node

# make sure it can run even when game is paused 
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

# take a screenshot the moment the action is _released_
# do this so we can hold it in to prep for the moment we want to capture then release
func _input(event: InputEvent) -> void:
	if OS.is_debug_build() && Input.is_action_just_released('screenshot'):
		take_screenshot()

# just saves screen shot into game app_data folder for now, so it will be
# [user]/AppData/Roaming/Godot/app_userdate/[Project]/[screenshot].png
func take_screenshot() -> void:
	var img = get_viewport().get_texture().get_image()
	var screenshot_path = ProjectSettings.get_setting("application/config/name") + "_" + Time.get_date_string_from_system() + "_" + Time.get_time_string_from_system() + ".png"
	screenshot_path = "user://" + screenshot_path.replace(' ','_').replace(':','_').replace('-','_')
	img.save_png(screenshot_path)
	print("Screenshot saved to: ", screenshot_path)
