extends PanelContainer

# Scene Loading
var current_player = Global.current_player_GL


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open_debug"):
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

func _on_increase_damage_pressed() -> void:
	current_player.boost_damage += 1
func _on_increase_defense_pressed() -> void:
	current_player.boost_defense += 1
func _on_increase_reload_pressed() -> void:
	current_player.boost_reload += 1
func _on_increase_score_pressed() -> void:
	current_player.boost_score += 1
func _on_increase_fragments_pressed() -> void:
	current_player.boost_fragments += 1
func _on_increase_energy_pressed() -> void:
	current_player.boost_cost += 1
func _on_invincible_pressed() -> void:
	current_player.invincible = !current_player.invincible
