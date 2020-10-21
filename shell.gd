extends RigidBody2D

# Declare member variables here. Examples:
export var speed = 400
var direction = Vector2(0.0, -1.0)
var rotation_deg = 78

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var rot_dir = direction.rotated(deg2rad(rotation_deg))
	self.rotate(deg2rad(rotation_deg))
	self.set_linear_velocity(rot_dir*speed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
