tool
extends VisualScriptCustomNode

var inputs = [
	{"name": "Player", "type": TYPE_OBJECT},
	{"name": "Area", "type": TYPE_OBJECT},
	{"name": "Move Speed", "type": TYPE_REAL},
]

# The name of the custom node as it appears in the search.
func _get_caption():
	return "Use ladder"

func _get_category():
	return "Input"

# The text displayed after the input port / sequence arrow.
func _get_text():
	return ""

func _get_input_value_port_count():
	return inputs.size()

func _get_input_value_port_name (idx):
	return inputs[idx]["name"]

# The types of the inputs per index starting from 0.
func _get_input_value_port_type(idx):
	return inputs[idx]["type"]

func _has_input_sequence_port():
	return true

# The number of output sequence ports to use
# (has to be at least one if you have an input sequence port).
func _get_output_sequence_port_count():
	return 1

func _step(inputs, outputs, start_mode, working_mem):
	var player = inputs[0]
	var area = inputs[1]
	var speed = inputs[2]
	
	player.limit_movement_y(area, speed)
	
	# Return the error string if an error occurred, else the id of the next sequence port.
	return 0
