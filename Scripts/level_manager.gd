extends Node2D


var current_player = Global.current_player_GL

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$GMBack/GameBox/HudLeft/EnergyBar.max_value = current_player.max_energy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$GMBack/GameBox/HudLeft/EnergyBar.value = current_player.current_energy


func _on_spawn_player_pressed() -> void:
	current_player.position = Vector2(300, 300)
	add_child(current_player)
