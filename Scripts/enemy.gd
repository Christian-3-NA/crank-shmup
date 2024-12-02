extends CharacterBody2D
'''
Base enemy scene that all others inherit from.
Just moves down.
'''

# Enemy Stats
var health = 3
var speed = 50
var spawn_position = Vector2.ZERO
var delay_time = 0


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(0, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Pauses the enemy processing before anything else happens
	# Would do this in a function but that makes a co-routine
	if delay_time > 0:
		await get_tree().create_timer(delay_time).timeout
		delay_time = 0
		
	# Does this second (after the spawn dleay) because nothing else matters if he dies
	if health <= 0:
		die()
		
	position += velocity * speed * delta # Change Pos


''' ---------- CUSTOM FUNCTIONS ---------- '''

func damaged(damage):
	health -= damage


func die():
	queue_free()


func delay():
	print("delay_timeweee")
	print("AHHHHHHHHHHHHHHHHHHH")
