extends HBoxContainer

signal data_chosen(times: PackedFloat64Array, quaternions: Array[Quaternion])

var fileDialogButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_load_button_pressed():
	$FileDialog.show();

# get chosen file
func _on_file_dialog_file_selected(path: String):
	print("Reading CSV from ", path);
	
	# open file, ignoring first row
	var file = FileAccess.open(path, FileAccess.READ)
	file.get_line()
	
	var times: PackedFloat64Array = []
	var quaternions: Array[Quaternion] = []
	
	# loop over lines of file
	while not file.eof_reached():
		# get array of comma-separated floats in line
		var line: PackedStringArray = file.get_line().split(",")
		
		# end if wrong number of entries on line
		if line.size() != 5:
			break
		
		# read floats from each line into `vals`
		var vals: PackedFloat64Array = []
		for elem in line:
			vals.append(elem.strip_edges().to_float())
		
		times.append(vals[0])
		quaternions.append(Quaternion(vals[1], vals[2], vals[3], vals[4]))

	file.close()
	
	emit_signal("data_chosen", times, quaternions)
	
	print("Read ", times.size(), " samples.")
	
	$Filename.text = 'File: "' + path.get_file() + '"'



