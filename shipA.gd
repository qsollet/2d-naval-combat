extends KinematicBody2D

export var acceleration = 1800
export var decceleration = 300
export var brake = 3000
export var max_speed = 600
export var mass = 2

var velocity = Vector2.ZERO
var rear_wheel_angle = 20
var front_wheel_angle = 0

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
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity = transform.x * acceleration
	#else:
	#	velocity = transform.x * decceleration
	if Input.is_action_pressed("ui_down"):
		pass
	
	# only dealing with rear steering
	var rear_steer_angle = 0.0
	if Input.is_action_pressed("ui_right"):
		rear_steer_angle -= deg2rad(rear_wheel_angle)
	if Input.is_action_pressed("ui_left"):
		rear_steer_angle += deg2rad(rear_wheel_angle)
	
	var rear_wheel_position = $rear_wheel.global_position + velocity.rotated(rear_steer_angle) * delta
	var front_wheel_position = $front_wheel.global_position + velocity * delta
	
	var new_heading = (front_wheel_position - rear_wheel_position).normalized()
	velocity = new_heading * velocity.length()
	rotation = new_heading.angle()
	
	move_and_slide(velocity)
	
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
