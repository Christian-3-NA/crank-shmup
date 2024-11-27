extends CharacterBody2D

# Player Stats
var health = 5
var speed = 100
var bullet_speed = 300
var fire_delay = 0.1
var max_energy = 30.0
var current_energy = max_energy

# State Bools
var recharging_bool = false

# Scene Loading
var bullet_scene = load("res://Scenes/bullet.tscn")


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Reloading. Does this before anything else because it changes your controls
	if Input.is_action_just_pressed("charge"):
		if recharging_bool == false:
			recharging_bool = true
		else:
			recharging_bool = false
	
	# Can only shoot and move when not recharging
	if !recharging_bool:
		# Movement Input
		var velocity = Vector2.ZERO
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1
		
		# Diagonal Normalization
		#if velocity.length() > 0:
		#	velocity = velocity.normalized() * speed
			
		position += velocity * speed * delta # Change Pos
		
		
		# Shooting Code
		if Input.is_action_pressed("shoot") and $FireDelayTimer.is_stopped():
			shoot_bullet()
			
	
	elif recharging_bool:
		if Input.is_action_just_pressed("shoot"):
			current_energy += 2
		if Input.is_action_just_released("shoot") and current_energy >= max_energy:
			current_energy = max_energy
			recharging_bool = false
	

''' ---------- CUSTOM FUNCTIONS ---------- '''
	
func shoot_bullet():
	# Check Energy
	if current_energy > 0:
		# Bullet delay, otherwise you're a touhou boss
		$FireDelayTimer.start(fire_delay)
		
		# Spawn bullets
		var next_bullet = bullet_scene.instantiate()
		next_bullet.speed = bullet_speed
		next_bullet.target_group = "enemy"
		next_bullet.velocity = Vector2(0, -1)
		next_bullet.position = self.position
		get_parent().add_child(next_bullet)
	
		# Energy Change
		current_energy -= 1
		if current_energy < 0:
			current_energy = 0
		
	else:
		pass
