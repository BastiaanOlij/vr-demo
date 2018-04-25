extends Spatial

var time_passed = 0.0
var target_fps = 30.0

func update_preview_size():
	var new_size = OS.window_size
	$ViewportContainer/Viewport.size = new_size

func _ready():
	# init our viewport size and register resize 
	update_preview_size()
	get_tree().get_root().connect("size_changed", self, "update_preview_size")
	
	# When exporting, only include the SDK you wish, find_interface won't return ones not installed.
	# Better is to have different init functions that only attempt what is needed. 
	var interface = ARVRServer.find_interface("Oculus")
	if interface and interface.initialize():
		#get_viewport().arvr = true
		pass
	else:
		interface = ARVRServer.find_interface("OpenVR")
		if interface and interface.initialize():
			#get_viewport().arvr = true
			#get_viewport().hdr = false
			$Viewport.hdr = false

func _process(delta):
	time_passed += delta
	if (time_passed > (1.0 / target_fps)):
		time_passed = 0.0
		$ViewportContainer/Viewport.render_target_update_mode = Viewport.UPDATE_ONCE
