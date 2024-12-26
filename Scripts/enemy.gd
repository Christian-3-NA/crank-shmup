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

#Scene Loading
var target = Global.current_player_GL
var powerup_scene = load("res://Scenes/powerup.tscn")


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
	# Score is modified by stats
	var modified_score = score + (score * target.boost_score * target.boost_scr_increase)
	Global.global_score += modified_score
	
	# Spawn powerup
	if Global.spawn_powerup_bool == true:
		# Powerup instantiation
		var next_powerup = powerup_scene.instantiate()
		next_powerup.powerup_type = target.next_powerup_type
		next_powerup.position = self.position
		get_parent().add_child(next_powerup)
		# Have to choose next powerup at spawn or else multiple powerups spawned
		# at once will have the same type
		target.last_powerup_type = target.next_powerup_type
		target.choose_next_powerup()
		Global.power_up_spawned.emit()
	
	queue_free()


func off_screen_clearing():
	if position.y > 488 or position.y < -128:
		queue_free()
