extends Node2D

# TEMP FUNCTIONS
var next_wave = 0

#Scene Loading
var rng = RandomNumberGenerator.new()
var current_player = Global.current_player_GL

''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


''' ---------- SIGNAL FUNCTIONS ---------- '''

func _on_spawn_enemy_pressed() -> void:
	# Test code for spawning an enemy randomly on the upper spawn range
	var next_enemy = load("res://Scenes/enemy.tscn").instantiate()
	# We use lerp here to provide an easy way to get a set % between the two spawn points
	next_enemy.position = $EnemySpawnN1.position.lerp($EnemySpawnN2.position, rng.randf())
	add_child(next_enemy)


func _on_spawn_aimer_pressed() -> void:
	# Test code for spawning an enemy randomly on the upper spawn range
	var next_enemy = load("res://Scenes/InheritedScenes/aimer_enemy.tscn").instantiate()
	# We use lerp here to provide an easy way to get a set % between the two spawn points
	next_enemy.position = $EnemySpawnN1.position.lerp($EnemySpawnN2.position, rng.randf())
	next_enemy.shooting_position = Vector2(200, 200)
	add_child(next_enemy)


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
			0:	next_enemy.position = $EnemySpawnN1.position.lerp($EnemySpawnN2.position, enemy_data[1][1])
			1:	next_enemy.position = $EnemySpawnL1.position.lerp($EnemySpawnL2.position, enemy_data[1][1])
			2:	next_enemy.position = $EnemySpawnR1.position.lerp($EnemySpawnR2.position, enemy_data[1][1])
		if enemy_data.size() > 2:
			for enemy_variables in enemy_data.slice(2):
				next_enemy.set(enemy_variables[0], enemy_variables[1])
		add_child(next_enemy)
