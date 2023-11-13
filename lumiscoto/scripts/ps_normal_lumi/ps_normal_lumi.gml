/// @description pb_state_stand()
function ps_normal_lumi() {
	// The "normal" state for the player. Includes support for idling and running.
	
	if(state_new)
	{
	    // 
	}
	
	// COLLISION CHECKING
	
	// Is the player standing on ground?
	var _ground_collision = place_meeting(x,y + 2, obj_collision_parent);

	// Has the player hit their head?
	var _roof_collision = place_meeting(x,y - 2, obj_collision_parent);
	
	// Is the player able to grab onto a ledge?
	var _climb_collision = instance_place(x,y, obj_climb);

	// Is the player in contact with a wall (for the purposes of wall climbing?)
	var _wall_collision_left = instance_place(x - 2 ,y, obj_wallclimb);
	var _wall_collision_right = instance_place(x + 2 ,y, obj_wallclimb);

	// COMPUTE X-SPEED
	
	// Unlike with the player, we don't want Lumi to have walk speed jumping at all, because this creates
	// the risk that she might kill herself while jumping
	if _ground_collision {
		on_the_ground = true;
		if walk {
			walk_active = true;
		} else {
			walk_active = false;
		}
	} else {
		walk_active = false;	
	}
	
	var _max_speed = move_speed;
	if walk_active {
		_max_speed = walk_speed;
	}
	
	// Acceleration computation
	if (move_input != 0) {
		// Are we moving with or against our momentum?
		if sign(move_x) == sign(move_input) {
			// We are moving *with* our momentum
			move_x += move_input*move_accel;
		} else {
			// We are moving *against* our momentum
			move_x += move_input*move_decel;
		}
		// Clamp the movement to prevent the player from exceeding their max speed.
		move_x = clamp(move_x, -_max_speed, _max_speed);
	} else if (move_x > 0) {
		move_x -= move_decel;
		move_x = clamp(move_x, 0, _max_speed);
	} else if (move_x < 0) {
		move_x += move_decel;
		move_x = clamp(move_x, -_max_speed, 0);
	}
	
	
	// GRAVITY
	
	if _ground_collision {
		
		// If the player is on flat ground, we want their next jump to be straight up
		jump_direction = pi/2;
		
		// The player is obviously not in the air at this point
		air_time = 0;
		move_y = 0;
		
	} else {
		// If the player is NOT on flat ground, bring them down with gravity
		move_y += grav;
		
		// The player is obviously in the air at this point
		air_time += 1;
	}
	
	// JUMPING
	
	// Code which handles *starting* a jump
	if (jump && air_time < coyote_time) {
		
		jump_active = true;
		move_x = move_x + jump_speed*cos(jump_direction);
		move_y = -jump_speed*sin(jump_direction);
	}
	
	// Code which handles *continuing* a jump
	if (jump_active) {
		
		// Allow the player to defy the effects of gravity for a short while should they continue to hold jump button
		move_y -= ((30 - air_time)/30)*grav;
		
		if (!jump || air_time > max_jumptime) {
			jump_active = false;	
		}
	}
	
	// What if we collide with a roof while jumping?
	if (_roof_collision && air_time > 1) {
			jump_active = false;
			if (move_y < 0) {
				move_y = 0;
			}
	}
	
	// If the player is travelling on a slope, ensure that they "adhere" to that slope
	if (place_meeting(x, y + slope_max, obj_collision_slope) && (move_y >= 0)) {
		while !place_meeting(x,y+1, obj_collision_parent) {
			y = y+1;	
		}
	}
	
	// Move the player
	var _arr = move_and_collide(move_x, move_y, obj_collision_parent, 4);

	// Ensure that the player does not fall through objects while moving
	//if (array_length(_arr) != 0 || place_meeting(x,y+move_y, obj_collision_parent)) {
	//	move_y = 0;	
	//} 
	
	// Display the appropriate sprite for the player 
	if (move_x != 0) {
		image_xscale = sign(move_x);
	}
	 
	// Is the player standing on solid ground?
	if (air_time < 2) { 
		// Yes, they are... 
		if move_x == 0 {
			sprite_index = spr_player_idle;   
		} else {
			if walk {
				sprite_index = spr_player_walk;	
			} else {
				sprite_index = spr_player_run;
				sprite_set_speed(spr_player_run, 12*((abs(move_x)+0.5*move_speed)/(1.5*move_speed)), spritespeed_framespersecond);
			}
		}	
	} else {
		// No, they are in mid-air
		sprite_index = spr_player_jump
		if abs(move_y) < jump_speed/3 {
			image_index = 1;
		} else if move_y > 0 {
			image_index = 2;
		} else {
			image_index = 0;	
		}
	}
	
	// In the LUMI code, there is no change of state that occurs.
}
