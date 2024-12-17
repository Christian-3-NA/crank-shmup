extends CharacterBody2D
'''
Base enemy scene that all others inherit from.
Just moves down.
'''

# Enemy Stats
@export var health = 3
@export var speed = 50
@export var score = 100
var spawn_position = Vector2.ZERO
var delay_time = 0
var target = Global.current_player_GL


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(0, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Pauses the enemy processing before anything else happens
	await get_tree().create_timer(delay_time).timeout
		
	# Does this second (after the spawn delay) because nothing else matters if he dies
	if health <= 0:
		die()
		
	position += velocity * speed * delta # Change Pos
	
	off_screen_clearing()


''' ---------- CUSTOM FUNCTIONS ---------- '''

func damaged(damage):
	health -= damage


func die():
	Global.global_score += score
	queue_free()


func off_screen_clearing():
	if position.y > 488 or position.y < -128:
		queue_free()
