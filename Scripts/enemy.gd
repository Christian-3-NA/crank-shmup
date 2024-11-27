extends CharacterBody2D
'''
Base enemy scene that all others inherit from.
Just moves down.
'''

# Enemy Stats
var health = 5
var speed = 50


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	velocity = Vector2(0, 1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * speed * delta # Change Pos
