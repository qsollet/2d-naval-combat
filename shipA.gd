extends RigidBody2D

export var speed = 10
var target = null

# Called when the node enters the scene tree for the first time.
func _ready():
	var elems = get_tree().get_nodes_in_group("target")
	for elem in elems:
		target = elem
	$turret1.target = target
	$turret2.target = target

func shoot():
	$turret1.shoot()
	$turret2.shoot()

func _process(delta):
	# Ship movement
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	self.position += velocity * self.speed * delta
	
	# Shoot
	if Input.is_action_pressed("ui_accept"):
		shoot()
		
	# Camera zoom
	if Input.is_action_pressed("ui_page_up"):
		$Camera2D.zoom.x += 0.1
		$Camera2D.zoom.y += 0.1
	if Input.is_action_pressed("ui_page_down"):
		$Camera2D.zoom.x -= 0.1
		$Camera2D.zoom.y -= 0.1
