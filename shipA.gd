extends RigidBody2D

export (PackedScene) var Shell
export var speed = 10
export var fire_timeout = 2
var target = null
var turret_rotation_speed = 1
var can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$ShootTimer.wait_time = self.fire_timeout
	var elems = get_tree().get_nodes_in_group("target")
	for elem in elems:
		target = elem

# function to rotate the turret
func aim(delta):
	if target:
		# TODO fix seem to aim from the center of the ship instead of the turret
		var target_rot = $turret1.get_angle_to(target.global_position)
		if abs(target_rot) > 0.01:
			var max_rot = delta * self.turret_rotation_speed
			if max_rot > abs(target_rot):
				$turret1.rotation += target_rot
			elif target_rot > 0:
				$turret1.rotation += max_rot
			else:
				$turret1.rotation -= max_rot

func shoot():
	if target and can_shoot:
		print("shoot")
		var b = Shell.instance()
		b.start($turret1.global_position, $turret1.global_rotation)
		get_parent().add_child(b)
		can_shoot = false
		$ShootTimer.start()

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
	
	# Shoot
	if Input.is_action_pressed("ui_accept"):
		shoot()

func _on_ShootTimer_timeout():
	print("reloaded")
	can_shoot = true
