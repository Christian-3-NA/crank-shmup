extends Control


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Button Groups
	var character_group = ButtonGroup.new()
	var character_reference = $RSSBack/RSSHBox/XPlayerOptions/XCharacter
	for child in character_reference.get_children():
		child.set_button_group(character_group)


''' ---------- SIGNAL FUNCTIONS ---------- '''

func _on_start_run_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game_manager.tscn")
