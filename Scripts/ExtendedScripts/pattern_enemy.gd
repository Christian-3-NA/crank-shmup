extends "res://Scripts/enemy.gd"
'''
Pattern type enemy.
Runs along a track, deals damage on collision.

When instantiating, give:
	track_pattern
'''

# Scene Loading
var path_to_follow = "PathCubic"
var path_follow = PathFollow2D.new()


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create a pathfollow node to use on CombatManager's paths
	path_follow.cubic_interp = false
	path_follow.loop = false
	get_parent().get_node(path_to_follow).add_child(path_follow)
	
	# Variable setting
	health = 2
	speed = 3
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Pauses the enemy processing before anything else happens
	if delay_time > 0:
		await get_tree().create_timer(delay_time).timeout
		delay_time = 0
		
	# Does this first because nothing else matters if he dies
	if health <= 0:
		die()
		
	# Moves along the path. doesnt interpolate because it makes it move non-linear
	path_follow.progress += speed
	position = path_follow.position


''' ---------- CUSTOM FUNCTIONS ---------- '''
