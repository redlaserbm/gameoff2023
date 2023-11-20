/// @description pb_state_air()
function ps_wallclimb() {
	//The in air State for Platform Boy
	if(state_new)
	{
		jump_active = false;
		air_time = 0;
	}

	// toss out the move_x calculation, we don't need it in this mode
	move_x = 0;
	
	// It's slippery holding onto walls!
	move_y = (1/16)*move_speed;
	
	// It is possible the player might slip off of walls while in wallclimb mode.
	// Check that there is still a collision of sorts and return to normal mode if there is none.
	if !( place_meeting(x+8,y, obj_wallclimb) || place_meeting(x-8,y, obj_wallclimb) ) {
		state_switch("Normal");
	}	
	
	// The player needs to actually "hold" himself to the wall to stay on it!
	if sign(move_input) != wallclimb_direction {
		x = x - 2*wallclimb_direction;
		state_switch("Normal");
	}
	
	// Jumping functionality
	if jump {
		
		jump_active = true;
		
		// Nudge the player a bit so they're free from the walls
		x = x - wallclimb_direction*2;
	
		// Make the player jump at an appropriate angle
		move_x = (jump_speed+walljump_bonus_speed)*cos(jump_direction);
		move_y = -(jump_speed+walljump_bonus_speed)*sin(jump_direction);
		
		// We only need to handle the initial part of the jump while in this mode.
		// On the next frame, upon switching to normal mode, *that* part of the code will handle continuing the jump
		state_switch("Normal");
	}
	
	// Move the player
	var _arr = move_and_collide(move_x, move_y, obj_collision_parent, 1);
	
	// Which sprites should the player use?
	sprite_index = spr_player_wallland;
	image_xscale = sign(wallclimb_direction);
	if state_timer < 2 {
		image_index = 0;
		sprite_set_speed(spr_player_wallland, 30, spritespeed_framespersecond);
	} else if image_index == 5 {
		sprite_set_speed(spr_player_wallland, 0, spritespeed_framespersecond);
	}

}
