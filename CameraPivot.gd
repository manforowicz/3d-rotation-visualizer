extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		self.rotation.y -= event.relative.x*0.01
		self.rotation.x -= event.relative.y*0.01
		self.rotation.x = clamp(self.rotation.x, -PI/2, PI/2)
