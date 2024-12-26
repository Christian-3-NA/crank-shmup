extends RigidBody2D

# Data
var powerup_type = ""

# Physics Variables 
var sprite_width

# Scene Loading
var rng = RandomNumberGenerator.new()
var target = Global.current_player_GL


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Sprite changing
	match powerup_type:
		"damage":
			$PowerupSprite.frame = 0
		"defense":
			$PowerupSprite.frame = 1
		"reload":
			$PowerupSprite.frame = 2
		"score":
			$PowerupSprite.frame = 3
		"fragments":
			$PowerupSprite.frame = 4
		"cost":
			$PowerupSprite.frame = 5
			
	sprite_width = $PowerupSprite.get_rect().size.x
	contact_monitor = true
	max_contacts_reported = 1 # Dont know what number this should be, 1 works fine
	lock_rotation = true
	gravity_scale = 0.1
	
	# Spawn force impulse, should only launch up-right or up-left
	var x_force = 0
	match randi_range(0, 1):
		0:
			x_force = -150
		1:
			x_force = 150
	apply_impulse(Vector2(x_force, -175))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Clamping functionality here (becuase clamp only works for vectors, i only needed it for the x position)
	if position.x < sprite_width/2:
		position.x = sprite_width/2
	elif position.x > 270-(sprite_width/2): # Prolly shouldnt hardcode the game width here. ovell
		position.x = 270-(sprite_width/2)
	
	# Bouncing code. Somehow this was the best way to do it, feels wrong though
	if position.x == sprite_width/2 or position.x == 270-(sprite_width/2):
		linear_velocity.x = linear_velocity.x * -1
		
	# Spinner Animation
	$Spinner.rotation_degrees += 5
	
	off_screen_clearing()


''' ---------- SIGNAL FUNCTIONS ---------- '''

func _on_body_entered(body: Node) -> void:
	if body == target:
		body.power_up_grabbed(powerup_type)
		queue_free()


''' ---------- CUSTOM FUNCTIONS ---------- '''

# This sepcific off_screen_clearing() only checks for downward position, the powerups can launch upwards off the screen
func off_screen_clearing():
	if position.y > 488:
		queue_free()
