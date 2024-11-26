extends Node

# Create the Player in global, this allows all scenes to easily access it's variables
var player_scene = load("res://Scenes/player.tscn")
var current_player_GL = player_scene.instantiate() # GL = global, to reduce confusion across scenes


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
