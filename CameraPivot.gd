extends Node3D

# let user changed view by dragging right click
func _input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		self.rotation.y -= event.relative.x*0.01
		self.rotation.x -= event.relative.y*0.01
		self.rotation.x = clamp(self.rotation.x, -PI/2, PI/2)
