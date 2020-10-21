extends KinematicBody2D

var speed = 750
var velocity = Vector2()
var duration = 3.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(duration)

func start(pos, rot):
	position = pos
	rotation = rot
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		print(collision.collider.name)
		print(collision.collider.parent.name)
		if collision.collider.has_method("hit"):
			if collision.collider.hit():
				queue_free()

func _on_Timer_timeout():
	queue_free()
