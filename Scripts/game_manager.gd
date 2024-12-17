extends Node2D


# Scene Loading
var current_player = Global.current_player_GL
var game_timer = Global.get_node("GameTimer")


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Score Display
	$GMBack/GameBox/LeftContainer/HudLeft/HLContents/ScoreLabel.text = "-SCORE-\n" + str(Global.global_score).pad_zeros(8)
	
	# Game Timer display. Changes detail as it decreases
	var time_display_ref = $GMBack/GameBox/LeftContainer/HudLeft/HLContents/TimeLeft
	#if game_timer.time_left > 300:
	#	time_display_ref.text = "%d" % [
	#		floor(game_timer.time_left / 60),
	#		]
	if game_timer.time_left > 60:
		time_display_ref.text = "%d:%02d" % [
			floor(game_timer.time_left / 60),
			int(game_timer.time_left) % 60,
			]
	else:
		time_display_ref.text = "%d:%02d:%02d" % [
			floor(game_timer.time_left / 60),
			int(game_timer.time_left) % 60,
			fmod(game_timer.time_left, 1) * 100
			]
