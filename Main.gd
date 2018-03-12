extends Spatial

func _ready():
	# When exporting, only include the SDK you wish, find_interface won't return ones not installed.
	# Better is to have different init functions that only attempt what is needed. 
	var interface = ARVRServer.find_interface("Oculus")
	if interface and interface.initialize():
		get_viewport().arvr = true
	else:
		interface = ARVRServer.find_interface("OpenVR")
		if interface and interface.initialize():
			get_viewport().arvr = true
			get_viewport().hdr = false