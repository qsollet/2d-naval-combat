extends RigidBody2D

# Declare member variables here. Examples:
export var shell1 = ""
export var speed = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Ready")
	var elems = get_tree().get_nodes_in_group("target")
	for elem in elems:
		print(elem)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	self.position += velocity * self.speed * delta
