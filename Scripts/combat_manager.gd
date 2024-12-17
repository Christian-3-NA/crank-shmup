extends Node2D

# TEMP FUNCTIONS
var next_wave = 0

# State Bools
var player_in_spawn_position = false

#Scene Loading
var rng = RandomNumberGenerator.new()
var current_player = Global.current_player_GL

''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_player.position = $Spawns/PlayerSpawn.position
	add_child(current_player)
	current_player.process_mode = PROCESS_MODE_DISABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_spawn_position == false:
		player_first_spawn(delta)


''' ---------- CUSTOM FUNCTIONS ---------- '''
	
func player_first_spawn(del):
	var rel_spawn_pos = $Spawns/PlayerSpawn.position + Vector2(0, -132)
	current_player.position = current_player.position.lerp(rel_spawn_pos, del * 2)
	if current_player.position.distance_to(rel_spawn_pos) < 10:
		current_player.process_mode = PROCESS_MODE_INHERIT
		player_in_spawn_position = true
		Global.get_node("GameTimer").start()


''' ---------- SIGNAL FUNCTIONS ---------- '''

func _on_spawn_player_pressed() -> void:
	current_player.position = Vector2($CMBack.get_size().x * .5, $CMBack.get_size().y * 0.8)
	add_child(current_player)


func _on_spawn_wave_pressed() -> void:
	next_wave = 0
	spawn_next_wave(next_wave)
	next_wave += 1
	
	
func _on_wave_timer_timeout() -> void:
	if next_wave >= Global.Levels_Dict["Level_1"].size():
		print("end!")
		return
	spawn_next_wave(next_wave)
	next_wave += 1


''' ---------- CUSTOM FUNCTIONS ---------- '''

func spawn_next_wave(next_wave):
	$WaveTimer.start(Global.Levels_Dict["Level_1"][next_wave][1])
	for enemy_data in Global.Levels_Dict["Level_1"][next_wave][0]:
		var next_enemy = Global.enemy_scenes[enemy_data[0]].instantiate()
		match enemy_data[1][0]:
			0:	next_enemy.position = $Spawns/EnemySpawnN1.position.lerp($Spawns/EnemySpawnN2.position, enemy_data[1][1])
			1:	next_enemy.position = $Spawns/EnemySpawnL1.position.lerp($Spawns/EnemySpawnL2.position, enemy_data[1][1])
			2:	next_enemy.position = $Spawns/EnemySpawnR1.position.lerp($Spawns/EnemySpawnR2.position, enemy_data[1][1])
		if enemy_data.size() > 2:
			for enemy_variables in enemy_data.slice(2):
				next_enemy.set(enemy_variables[0], enemy_variables[1])
		add_child(next_enemy)


''' ---------- OLD FUNCTIONS ----------

func _on_spawn_enemy_pressed() -> void:
	# Test code for spawning an enemy randomly on the upper spawn range
	var next_enemy = load("res://Scenes/enemy.tscn").instantiate()
	# We use lerp here to provide an easy way to get a set % between the two spawn points
	next_enemy.position = $EnemySpawnN1.position.lerp($EnemySpawnN2.position, rng.randf())
	add_child(next_enemy)
	
'''
