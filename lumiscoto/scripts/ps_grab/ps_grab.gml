/// @description pb_state_stand()
function ps_grab() {
	//The Standing State for Platform Boy
	if(state_new)
	{
		air_time = 0;
	    grab_time = 0;
		jump_active = false;
	}
	
	grab_time += 1;
	
	sprite_index = spr_player_climb;
	image_xscale = grab_direction;
	
	if grab_time < 10 {
		x = start_x;
		y = start_y;
		image_index = 0;
	} else if grab_time < 40 {
		image_index = 1;
	} else if grab_time < 50 {
		image_index = 2;
	} else if grab_time < 60 {
		image_index = 3;
		x = start_x + grab_direction*8;
		y = start_y - 16;
	} else if grab_time < 70 {
		image_index = 4;
		x = start_x + grab_direction*16;
		y = start_y - 24;
	} else {
		state_switch("Normal");
		move_x = 0;
		move_y = 0;
	}
	
}
