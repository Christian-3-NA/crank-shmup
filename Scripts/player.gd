extends CharacterBody2D

# Player Stats
var health = 5
var speed = 100
var bullet_speed = 300
var fire_delay = 0.1

# Scene Loading
var bullet_scene = load("res://Scenes/bullet.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
	
	
func shoot_bullet():
	$FireDelayTimer.start(fire_delay)
	var next_bullet = bullet_scene.instantiate()
	next_bullet.speed = bullet_speed
	next_bullet.target_group = "enemy"
	next_bullet.velocity = Vector2(0, -1)
	next_bullet.position = self.position
	get_parent().add_child(next_bullet)
