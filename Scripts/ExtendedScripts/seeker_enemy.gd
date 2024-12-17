extends "res://Scripts/enemy.gd"
'''
Seeker type enemy.
Flies into a set position then charges directly at the player.

When instantiating, give:
	relative_launch_pos
'''

# Enemy Stats
var collision_damage = 5
var launching_position = Vector2.ZERO
var relative_launch_pos = Vector2.ZERO
var launch_speed = 400
var launch_wait_time = 1

# State Bools
var reached_target = false



''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# This code is run here because it can't be done in the Levels data
	launching_position = position + relative_launch_pos
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Pauses the enemy processing before anything else happens
	await get_tree().create_timer(delay_time).timeout
		
	# Does this second (after the spawn delay) because nothing else matters if he dies
	if health <= 0:
		die()
		
	# Ease into position from spawn, wait, then launch to player
	if reached_target:
		position += velocity * speed * delta
	else:
		position = position.lerp(launching_position, delta * speed) 
		# await needs to be outside the if, otherwise itll create a co-routine
		await get_tree().create_timer(launch_wait_time).timeout
		if position.distance_to(launching_position) < 10:
			reached_target = true
			velocity = position.direction_to(target.position)
			speed = launch_speed


''' ---------- CUSTOM FUNCTIONS ---------- '''

# Collision Damage
func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body == target:
		body.damaged(collision_damage)
