extends RigidBody2D

# Declare member variables here. Examples:
export var shell1 = ""
export var speed = 10
var target = null
var turret_rotation_speed = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	var elems = get_tree().get_nodes_in_group("target")
	for elem in elems:
		target = elem

# function to rotate the turret
func aim(delta):
	if target:
		var target_rot = $turret1.get_angle_to(target.position)
		if abs(target_rot) > 0.01:
			var max_rot = delta * self.turret_rotation_speed
			if max_rot > abs(target_rot):
				$turret1.rotation += target_rot
			elif target_rot > 0:
				$turret1.rotation += max_rot
			else:
				$turret1.rotation -= max_rot

# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	
	# Turret aim
	aim(delta)
