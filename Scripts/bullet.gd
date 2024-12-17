extends Area2D

# Bullet Stats
var target_group = ""
var damage = 1
var velocity = Vector2(1, 0)
var speed = 200


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += velocity * speed * delta
	
	off_screen_clearing()


func off_screen_clearing():
	if position.y > 488 or position.y < -128:
		queue_free()


''' ---------- SIGNAL FUNCTIONS ---------- '''

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(target_group):
		body.damaged(damage)
		queue_free()
