extends "res://Scripts/enemy.gd"
'''
Pattern type enemy.
Flies into a set position then begins firing a pattern of bullets.

When instantiating, give:
	relative_shoot_pos
	shooting_pattern (defaults to 0)
'''

# Enemy Stats
var bullet_speed = 75
var bullet_damage = 3
var shooting_position = Vector2.ZERO
var relative_shoot_pos = Vector2.ZERO
var shooting_pattern = 0
var next_bullet_index = 0

# Scene Loading
var bullet_scene = load("res://Scenes/bullet.tscn")

# Custom data
var patterns = [ # Should probably not store this here. Oh well.
	[ # first layer is bullet pattern. next contains each bullet, which contain direction and delay
		[Vector2(0, 1), .1], # Direction is just a vector (which is normalized later), delay is in seconds
		[Vector2(0.2, 1), .1],
		[Vector2(0.4, 1), .1],
		[Vector2(0.6, 1), 1.5],
		[Vector2(0, 1), .1],
		[Vector2(-0.2, 1), .1],
		[Vector2(-0.4, 1), .1],
		[Vector2(-0.6, 1), 1.5]
	],
	[
		[Vector2(0, 1), .1]
	],
	[
		[Vector2(0, 1), .1]
	]
]

''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Prevents firing as soon as they spawn in
	$FireDelayTimer.start(.5)

	# This code is run here because it can't be done in the Levels data
	shooting_position = position + relative_shoot_pos
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Pauses the enemy processing before anything else happens
	await get_tree().create_timer(delay_time).timeout
		
	# Does this second (after the spawn delay) because nothing else matters if he dies
	if health <= 0:
		die()
		
	# Ease into position from spawn
	position = position.lerp(shooting_position, delta * speed)
	
	# Shooting Code
	if $FireDelayTimer.is_stopped():
		shoot_bullet(patterns[shooting_pattern][next_bullet_index])


''' ---------- CUSTOM FUNCTIONS ---------- '''

func shoot_bullet(bullet_data):
	$FireDelayTimer.start(bullet_data[1])
	var next_bullet = bullet_scene.instantiate()
	next_bullet.target_group = "player"
	next_bullet.velocity = bullet_data[0].normalized()
	next_bullet.position = self.position
	next_bullet.speed = self.bullet_speed
	next_bullet.damage = self.bullet_damage
	get_parent().add_child(next_bullet)
	
	next_bullet_index += 1
	if next_bullet_index >= patterns[shooting_pattern].size():
		next_bullet_index = 0
