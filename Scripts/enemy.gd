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
var target = Global.current_player_GL


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(0, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# Does this first because nothing else matters if he dies
	if health <= 0:
		die()
		
	position += velocity * speed * delta # Change Pos
	
	off_screen_clearing()


''' ---------- CUSTOM FUNCTIONS ---------- '''

func damaged(damage):
	health -= damage


func die():
	Global.global_score += score
	if Global.spawn_powerup_bool == true:
		get_parent().add_child(load("res://Scenes/bullet.tscn").instantiate())
		Global.power_up_spawned.emit()
	queue_free()


func off_screen_clearing():
	if position.y > 488 or position.y < -128:
		queue_free()
