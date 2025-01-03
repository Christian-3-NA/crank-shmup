extends Node2D


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


''' ---------- SIGNAL FUNCTIONS ---------- '''

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/run_select_screen.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
