extends TextureProgressBar

# Scene Loading
var current_player = Global.current_player_GL


''' ---------- DEFAULT FUNCTIONS ---------- '''

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	max_value = get_size().y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#queue_redraw()
	#max_value = current_player.max_energy
	#value = current_player.current_energy
	
	# Displayed value must be exactly 5 pixels lower than true energy value.
	# height will change if energy cap sprite is different.
	value = max_value * (current_player.current_energy / current_player.max_energy)

	# OLD CODE FOR MOVING THE CAP ON THE ENERGY. THIS FILE IS MESSY.
	'''
	# Cap moving
	if value == max_value:
		$EnergyCap.hide()
	else:
		$EnergyCap.show()'''
	
	$EnergyCap.position.y = get_size().y * (1- (value / max_value))

# Taken from stack overflow so im not gonna touch it
'''func _draw():
	var bar_height = get_size().y
	var bar_width = get_size().x
	var line_width = 1
	var energy_per_line = 5
	var lines_to_draw = Global.current_player_GL.max_energy / energy_per_line
	
	if lines_to_draw > 0:
		var pixel_per_line = bar_height / lines_to_draw
		var draw_pos_y = pixel_per_line
		for i in lines_to_draw:
			if draw_pos_y < bar_height:
				draw_line(Vector2(0, draw_pos_y), Vector2(bar_width, draw_pos_y), Color(0,0,0,1), line_width)
			draw_pos_y = draw_pos_y + pixel_per_line'''
