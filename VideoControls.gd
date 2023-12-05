extends Node

var times: PackedFloat64Array = []
var quaternions: Array[Quaternion] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# if play is currently pressed, move the video slider
	if $Play.button_pressed:
		$VideoSlider.value += delta * $Speed.value

# when user loads CSV data, move slider to beginning and start playing
func _on_load_csv_data_chosen(times_val: PackedFloat64Array, quaternions_val: Array[Quaternion]):
	self.times = times_val
	self.quaternions = quaternions_val
	if !times.is_empty():
		$VideoSlider.max_value = self.times[self.times.size() - 1]
		$VideoSlider.value = 0;
		$Play.disabled = false
		$Play.button_pressed = true

# if play pressed at end of video, move slider to beginning
func _on_play_toggled(button_pressed: bool):
	if button_pressed and $VideoSlider.value >= $VideoSlider.max_value:
		$VideoSlider.value = 0.0

# when slider moves, update stuff
func _on_video_slider_value_changed(value):
	# update time displayed on label
	$Time.text = String.num($VideoSlider.value).pad_decimals(1) + "s"
	
	# update satellite orientation
	var i = times.bsearch($VideoSlider.value)
	if i < quaternions.size():
		%Satellite.quaternion = quaternions[i]
	
	# if slider reached end, stop playing
	if $VideoSlider.value >= $VideoSlider.max_value:
		$Play.button_pressed = false

# stop playing video when user drags slider
func _on_video_slider_drag_started():
	$Play.button_pressed = false
