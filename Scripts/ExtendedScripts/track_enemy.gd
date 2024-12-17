extends "res://Scripts/enemy.gd"
'''
Track type enemy.
Runs along a track, deals damage on collision.

When instantiating, give:
	path_to_follow
'''

# Scene Loading
var collision_damage = 5
var path_to_follow = "Paths/PCubic"
var path_follow = PathFollow2D.new()


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create a pathfollow node to use on CombatManager's paths
	path_follow.cubic_interp = false
	path_follow.loop = false
	get_parent().get_node(path_to_follow).add_child(path_follow)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Pauses the enemy processing before anything else happens
	await get_tree().create_timer(delay_time).timeout
	
	# Does this second (after the spawn delay) because nothing else matters if he dies
	if health <= 0:
		die()
		
	# Moves along the path. doesnt interpolate because it makes it move non-linear
	path_follow.progress += speed
	position = path_follow.position


''' ---------- CUSTOM FUNCTIONS ---------- '''

# Collision Damage
func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body == target:
		body.damaged(collision_damage)
