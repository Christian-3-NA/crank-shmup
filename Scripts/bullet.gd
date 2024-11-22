extends Area2D

var target_group = ""
var velocity = Vector2(1, 0)
var speed = 200


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * speed * delta
