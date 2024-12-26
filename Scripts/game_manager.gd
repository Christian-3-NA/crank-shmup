extends Node2D

# Powerup drop meter
var previous_score = 0
var powerup_meter_progress = 0

# Scene Loading
var current_player = Global.current_player_GL
var game_timer = Global.get_node("GameTimer")
@onready var powerup_meter = $GMBack/GameBox/LeftContainer/HudLeft/LeftPanelBG/ScorePanel/ScoreBar


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Global signal connection
	Global.power_up_spawned.connect(reset_meter)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Score Display
	var display_score = str(Global.global_score).pad_zeros(9)
	display_score = display_score.insert(3, ",").insert(7, ",")
	$GMBack/GameBox/LeftContainer/HudLeft/LeftPanelBG/ScorePanel/ScoreLabel.text = display_score
	
	# Score upgrade drop display. Keep full until enemy is killed then reset
	if previous_score != Global.global_score:
		powerup_meter.value += (Global.global_score - previous_score) / 100
		previous_score = Global.global_score
	#powerup_meter.value = powerup_meter_progress / 100
	if powerup_meter.value == powerup_meter.max_value:
		Global.spawn_powerup_bool = true
		
	# Stats display
	$GMBack/GameBox/LeftContainer/HudLeft/LeftPanelBG/Stats/DamageBar.value = current_player.boost_damage
	$GMBack/GameBox/LeftContainer/HudLeft/LeftPanelBG/Stats/DefenseBar.value = current_player.boost_defense
	$GMBack/GameBox/LeftContainer/HudLeft/LeftPanelBG/Stats/ReloadBar.value = current_player.boost_reload
	$GMBack/GameBox/LeftContainer/HudLeft/LeftPanelBG/Stats/ScoreBar.value = current_player.boost_score
	$GMBack/GameBox/LeftContainer/HudLeft/LeftPanelBG/Stats/FragmentsBar.value = current_player.boost_fragments
	$GMBack/GameBox/LeftContainer/HudLeft/LeftPanelBG/Stats/CostBar.value = current_player.boost_cost
	
	# Game Timer display. Changes detail as it decreases
	var time_display_ref = $GMBack/GameBox/RightContainer/RightPanelBG/TimerPanel/TimeLeft
	#if game_timer.time_left > 300:
	#	time_display_ref.text = "%d" % [
	#		floor(game_timer.time_left / 60),
	#		]
	if game_timer.time_left > 60 and (game_timer.time_left > 360 or game_timer.time_left < 300) and (game_timer.time_left > 660 or game_timer.time_left < 600):

		time_display_ref.text = "%d:%02d" % [
			floor(game_timer.time_left / 60),
			int(game_timer.time_left) % 60,
			]
	else:
		time_display_ref.text = "%02d:%02d" % [
			#floor(game_timer.time_left / 60),
			int(game_timer.time_left) % 60,
			fmod(game_timer.time_left, 1) * 100
			]


''' ---------- SIGNAL FUNCTIONS ---------- '''

func reset_meter():
	powerup_meter.value = 0
	Global.spawn_powerup_bool = false
