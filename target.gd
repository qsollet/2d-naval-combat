extends Area2D

# Declare member variables here. Examples:
var text
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is RichTextLabel:
		  text = child

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_target_body_shape_entered(body_id, body, body_shape, local_shape):
	text.push_color( Color.red )
	text.set_text("BOOM")
	timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(0.5)
	timer.connect("timeout", self, "_on_timer_timeout") 
	timer.start()

func _on_timer_timeout():
	print("Timeout")
	text.set_text("")
	timer.stop()
