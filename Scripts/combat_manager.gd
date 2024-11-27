extends Node2D

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
	current_player.position = Vector2(150, 150)
	add_child(current_player)
