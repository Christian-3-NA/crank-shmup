extends "res://Scripts/enemy.gd"
'''
Aimer type enemy.
Flies into a set position then begins firing bullets directly at the player.

When instantiating, give:
	shooting_position
'''

# Enemy Stats
var bullet_speed = 150
var fire_delay = 2
var shooting_position = Vector2.ZERO
var relative_shoot_pos = Vector2.ZERO
var target = Global.current_player_GL

# Scene Loading
var bullet_scene = load("res://Scenes/bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Prevents firing as soon as they spawn in
	$FireDelayTimer.start(fire_delay)
	
	# Needs to be low for lerp to look right
	speed = 3
	
	# This code is run here because it can't be done in the Levels data
	shooting_position = shooting_position + relative_shoot_pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Ease into position from spawn
	position = position.lerp(shooting_position, delta * speed)
	
	# Shooting Code
	if $FireDelayTimer.is_stopped():
		shoot_bullet()


''' ---------- CUSTOM FUNCTIONS ---------- '''

func shoot_bullet():
	$FireDelayTimer.start(fire_delay)
	var next_bullet = bullet_scene.instantiate()
	next_bullet.target_group = "player"
	next_bullet.velocity = self.position.direction_to(self.target.position)
	next_bullet.position = self.position
	next_bullet.speed = self.bullet_speed
	get_parent().add_child(next_bullet)
