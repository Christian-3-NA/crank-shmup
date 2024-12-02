extends ProgressBar


var current_player = Global.current_player_GL


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	max_value = current_player.max_energy
	value = current_player.current_energy


# Taken from stack overflow so im not gonna touch it
func _draw():
	var bar_height = get_size().y
	var bar_width = get_size().x
	var line_width = 3
	var energy_per_line = 5
	var lines_to_draw = Global.current_player_GL.max_energy / energy_per_line
	
	if lines_to_draw > 0:
		var pixel_per_line = bar_height / lines_to_draw
		var draw_pos_y = pixel_per_line
		for i in lines_to_draw:
			if draw_pos_y < bar_height:
				draw_line(Vector2(0, draw_pos_y), Vector2(bar_width, draw_pos_y), Color(0,0,0,1), line_width)
			draw_pos_y = draw_pos_y + pixel_per_line
