extends Node

var times: PackedFloat64Array = []
var quaternions: Array[Quaternion] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Play.button_pressed:
		$VideoSlider.value += delta * $Speed.value


func _on_load_csv_data_chosen(times: PackedFloat64Array, quaternions: Array[Quaternion]):
	self.times = times
	self.quaternions = quaternions
	if !times.is_empty():
		$VideoSlider.max_value = self.times[self.times.size() - 1]
		$VideoSlider.value = 0;
		$Play.disabled = false
		$Play.button_pressed = true


func _on_play_toggled(button_pressed: bool):
	if button_pressed and $VideoSlider.value >= $VideoSlider.max_value:
		$VideoSlider.value = 0.0


func _on_video_slider_value_changed(value):
	$Time.text = String.num($VideoSlider.value).pad_decimals(1) + "s"
	
	var i = times.bsearch($VideoSlider.value)
	if i < quaternions.size():
		%Satellite.quaternion = quaternions[i]
	
	if $VideoSlider.value >= $VideoSlider.max_value:
		$Play.button_pressed = false
