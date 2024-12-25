extends CharacterBody2D

# Player Stats
var health = 5
var speed = 175
var bullet_speed = 400
var fire_delay = 0.1
var accel_percent = 0
# Energy
var max_energy = 30.0
var current_energy = max_energy
var bullet_cost = 1
var recharge_amount = 1
var time_to_max_ramp = 0.5
var hit_stun_time = 0.5

# Animation
var relative_rotation = 0

# State Bools
var recharging_bool = false

# Scene Loading
var bullet_scene = load("res://Scenes/bullet.tscn")


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Does this first because nothing else matters if he dies
	if health <= 0:
		die()
	
	# Reloading. Does this before anything else because it changes your controls
	if Input.is_action_just_pressed("charge"):
		if recharging_bool == false and current_energy != max_energy:
			velocity = Vector2.ZERO
			$ChargeRampTimer.start(time_to_max_ramp)
			recharging_bool = true
			$PlayerSprite.frame = 1
			$PlayerSprite.offset.x = 0
			$ReloadingSprite.show()
		else:
			# This is necessary to continue movement after releasing reload
			check_movement()
			recharging_bool = false
			$ReloadingSprite.hide()
			$ReloadingSprite.rotation_degrees = 0
			relative_rotation = 0
	
	# Can only shoot and move when not recharging
	if !recharging_bool:
		# Movement Input
		# This long chunk of repeated code is to allow for input overwriting.
		# Movement check is a part of this functionality
		if Input.is_action_just_pressed("move_right"):
			velocity.x = 1
		if Input.is_action_just_pressed("move_left"):
			velocity.x = -1
		if Input.is_action_just_pressed("move_down"):
			velocity.y = 1
		if Input.is_action_just_pressed("move_up"):
			velocity.y = -1
			
		if Input.is_action_just_released("move_right") and velocity.x == 1:
			velocity.x = 0
			if Input.is_action_pressed("move_left"):
				velocity.x = -1
		if Input.is_action_just_released("move_left") and velocity.x == -1:
			velocity.x = 0
			if Input.is_action_pressed("move_right"):
				velocity.x = 1
		if Input.is_action_just_released("move_down") and velocity.y == 1:
			velocity.y = 0
			if Input.is_action_pressed("move_up"):
				velocity.y = -1
		if Input.is_action_just_released("move_up") and velocity.y == -1:
			velocity.y = 0
			if Input.is_action_pressed("move_down"):
				velocity.y = 1
			
		'''if Input.is_action_pressed("move_right"):
			velocity.x += 1
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1'''
		
		# Diagonal Normalization (broken right now? dunno what its problem is)
		#if velocity.length() > 0:
		#	velocity = velocity.normalized() * speed
			
		# Movement acceleration code, minimal impact intended for precision movement only
		if velocity == Vector2.ZERO:
			accel_percent -= .2
			accel_percent = max(accel_percent, 0)
		else:
			accel_percent += .2
			accel_percent = min(accel_percent, 1)
		position += velocity * delta * speed * accel_percent # If you put normalization back on, remove * speed
		
		# Sprite changing
		if velocity.x > 0:
			$PlayerSprite.frame = 2
			$PlayerSprite.offset.x = -2
		elif velocity.x < 0:
			$PlayerSprite.frame = 0
			$PlayerSprite.offset.x = 2
		else: 
			$PlayerSprite.frame = 1
			$PlayerSprite.offset.x = 0
		
		# Position clamping to screen
		var clamp_offset = $PlayerSprite.get_rect().size * $PlayerSprite.scale / 2 # Defining this here because i only use it below
		position = position.clamp(Vector2.ZERO + clamp_offset, get_parent().get_node("CMBack").size - clamp_offset)
		
		# Shooting Code
		if Input.is_action_pressed("shoot") and $FireDelayTimer.is_stopped():
			shoot_bullet()
			
	
	elif recharging_bool:
		# Speeeens the reloading sprite
		$ReloadingSprite.rotation_degrees = $ReloadingSprite.rotation_degrees + (relative_rotation - $ReloadingSprite.rotation_degrees) * (delta * 2)
		
		# Variable charge amount depening on how long you've been in this state
		var new_recharge_amount = recharge_amount * (1 - ($ChargeRampTimer.time_left / time_to_max_ramp))
		new_recharge_amount = max(new_recharge_amount, 0)
		if Input.is_action_just_pressed("shoot"):
			increase_energy(new_recharge_amount)
		if Input.is_action_just_pressed("move_right"):
			increase_energy(new_recharge_amount)
		if Input.is_action_just_pressed("move_left"):
			increase_energy(new_recharge_amount)
		if Input.is_action_just_pressed("move_down"):
			increase_energy(new_recharge_amount)
		if Input.is_action_just_pressed("move_up"):
			increase_energy(new_recharge_amount)
			
		if current_energy >= max_energy:
			current_energy = max_energy
			recharging_bool = false
			$ReloadingSprite.hide()
			$ReloadingSprite.rotation_degrees = 0
			relative_rotation = 0
			check_movement()


''' ---------- CUSTOM FUNCTIONS ---------- '''
	
func damaged(damage):
	# Resets your charge ramp when hit to discourage tanking
	if recharging_bool == true:
		$ChargeRampTimer.start(time_to_max_ramp + hit_stun_time)
		$ReloadingSprite.rotation_degrees = 0
		relative_rotation = 0
			
	if current_energy == 0:
		die()
	else:
		current_energy = max(0, current_energy - damage)


func die():
	print("DEAD")
	health = 10
	#queue_free()


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
		next_bullet.get_node("BulletSprite").texture = load("res://Assets/Art/cshm_bullet.png")
		next_bullet.get_node("BulletSprite").scale = Vector2(1, 1)
		get_parent().add_child(next_bullet)
	
		# Energy Change. We do max here to put it in one line
		current_energy = max(0, current_energy - bullet_cost)
		
	else:
		pass


func increase_energy(amount):
	current_energy += amount
	relative_rotation += 90


func check_movement():
	if Input.is_action_pressed("move_right"):
		velocity.x = 1
	if Input.is_action_pressed("move_left"):
		velocity.x = -1
	if Input.is_action_pressed("move_down"):
		velocity.y = 1
	if Input.is_action_pressed("move_up"):
		velocity.y = -1
