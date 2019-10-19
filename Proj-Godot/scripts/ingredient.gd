extends RigidBody2D

signal clicked

func _ready():
	$Button.connect("button_down",self,"button_pressed")

func impulse_from_right():
	apply_central_impulse(Vector2(400,-randf()*800-400))

func impulse_from_left():
	apply_central_impulse(Vector2(-400,-randf()*800-400))

func button_pressed():
	emit_signal("clicked",self.name)
	queue_free()

