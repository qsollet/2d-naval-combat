extends KinematicBody2D

var speed = 750
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start(pos, rot):
	position = pos
	rotation = rot
	self.velocity = Vector2(self.speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			if collision.collider.hit():
				queue_free()
