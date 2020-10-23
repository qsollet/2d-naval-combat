extends Node2D


export (PackedScene) var Shell
export var rotation_speed = 1.5
export var fire_timeout = 2
var target = null
var can_shoot = true


func _ready():
	$ShootTimer.wait_time = self.fire_timeout


func _process(delta):
	aim(delta)


func aim(delta):
	if target:
		var target_rot = get_angle_to(target.global_position)
		if abs(target_rot) > 0.01:
			var max_rot = delta * self.rotation_speed
			if max_rot > abs(target_rot):
				rotation += target_rot
			elif target_rot > 0:
				rotation += max_rot
			else:
				rotation -= max_rot


func shoot():
	if target and can_shoot:
		var b = Shell.instance()
		b.start(global_position, global_rotation)
		get_tree().get_root().add_child(b)
		can_shoot = false
		$ShootTimer.start()


func _on_ShootTimer_timeout():
	can_shoot = true
