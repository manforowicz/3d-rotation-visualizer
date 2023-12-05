extends HBoxContainer

signal data_chosen(times: PackedFloat64Array, quaternions: Array[Quaternion])

var fileDialogButton

# ask user to select a file when load button pressed
func _on_load_button_pressed():
	$FileDialog.show();

# parse CSV data from selected file, and send it in the data_chosen signal
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
		var real = vals[1]
		var i = vals[2]
		var j = vals[3]
		var k = vals[4]
		quaternions.append(Quaternion(i, j, k, real))

	file.close()
	
	emit_signal("data_chosen", times, quaternions)
	
	print("Read ", times.size(), " samples.")
	
	$Filename.text = 'File: "' + path.get_file() + '"'
