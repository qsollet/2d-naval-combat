extends Area2D

func _ready():
	pass

func _process(delta):
	pass

func _on_target_body_shape_entered(body_id, body, body_shape, local_shape):
	$RichTextLabel.push_color( Color.red )
	$RichTextLabel.set_text("BOOM")
	$Timer.set_wait_time(0.5)
	$Timer.start()

func _on_Timer_timeout():
	print("Timeout")
	$RichTextLabel.set_text("")
