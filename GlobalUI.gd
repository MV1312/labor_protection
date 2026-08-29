extends CanvasLayer

# List of scenes where button SHOULD appear
var scenes_with_button = [
	"res://levels/level1.tscn",
	"res://levels/level2.tscn",
	"res://shop.tscn",
    "res://settings.tscn"
]

# List of scenes where button should NOT appear
var scenes_without_button = [
	"res://main.tscn",
    "res://loading_screen.tscn"
]

func _ready():
	# Hide button by default
	$BackButton.hide()
	# Update visibility when new scene loads
	update_button_visibility()

func update_button_visibility():
	var current_scene = get_tree().current_scene.scene_file_path
	
	# Check if button should be shown
	var show_button = current_scene in scenes_with_button
	
	# If scene is in blacklist - hide button
	if current_scene in scenes_without_button:
		show_button = false
	
	$BackButton.visible = show_button

func show_back_button(show: bool):
	$BackButton.visible = show

func _on_back_button_pressed():
	# Return to main menu
	get_tree().change_scene_to_file("res://main.tscn")
