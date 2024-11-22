extends CharacterBody2D

# Enemy Stats
var health = 5
var speed = 50
var bullet_speed = 300
var fire_delay = 1
var delay_variation = 2


# Scene Loading
var bullet_scene = load("res://Scenes/bullet.tscn")
var rng = RandomNumberGenerator.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(0, 1)
	# Prevents firing as soon as they spawn in
	$FireDelayTimer.start(fire_delay + rng.randf_range(0, delay_variation))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * speed * delta # Change Pos

	# Shooting Code
	if $FireDelayTimer.is_stopped():
		shoot_bullet()


func shoot_bullet():
	var rand_delay = rng.randf_range(0, delay_variation)
	$FireDelayTimer.start(fire_delay + rand_delay)
	var next_bullet = bullet_scene.instantiate()
	next_bullet.target_group = "player"
	next_bullet.velocity = Vector2(0, 1)
	next_bullet.position = self.position
	get_parent().add_child(next_bullet)
