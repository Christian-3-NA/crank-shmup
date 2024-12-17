extends PanelContainer


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open_menu"):
		pause()


''' ---------- CUSTOM FUNCTIONS ---------- '''
	
func pause():
	if get_tree().paused == true:
		get_tree().paused = false
		hide()
	else:
		get_tree().paused = true
		show()

''' ---------- SIGNAL FUNCTIONS ---------- '''

func _on_b_resume_pressed() -> void:
	pause()

func _on_b_quit_pressed() -> void:
	get_tree().quit()
