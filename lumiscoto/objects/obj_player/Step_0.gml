/// @description Insert description here
// You can write your code in this editor

// get input
var _move_input = keyboard_check(vk_right) - keyboard_check(vk_left);
var _up_input = keyboard_check(vk_up);
var _jump = keyboard_check_pressed(vk_space);
var _hold_space = keyboard_check(vk_space);

// calc movement
if _move_input != 0 {
	// Are we moving with or against our momentum?
	if sign(move_x) == sign(_move_input) {
		// We are moving *with* our momentum
		move_x += _move_input*move_accel;
	} else {
		// We are moving *against* our momentum
		move_x += _move_input*move_decel;
	}
	
	// Clamp the movement to prevent the player from exceeding their max speed.
	move_x = clamp(move_x, -move_speed, move_speed);
} else if move_x > 0 {
	move_x -= move_decel;
	move_x = clamp(move_x, 0, move_speed);
} else if move_x < 0 {
	move_x += move_decel;
	move_x = clamp(move_x, -move_speed, 0);
}

// Is the player standing on ground?
var _ground_collision = place_meeting(x,y + 2, obj_collision_parent);

// Is the player able to grab onto a ledge?
var _climb_collision = instance_place(x,y, obj_climb);

// Is the player in contact with a wall (for the purposes of wall climbing?)
var _wall_collision_left = instance_place(x - 2 ,y, obj_wallclimb);
var _wall_collision_right = instance_place(x + 2 ,y, obj_wallclimb);


// vertical movement
if not _ground_collision {
	move_y += grav;
}

// OPTIONAL ACTIONS

if !_hold_space {
	jump_stopped = true;	
}

// If the player starts jumping from a *normal* position...
if (_jump && air_time < coyote_time && movement_mode == "normal") {
	
	// Has the player let go of the jump key yet? Obviously no at this point.
	jump_stopped = false;
	
	// Make the player go up!
	if _ground_collision {
		jump_direction = pi/2;
	}
	
	// Adjust the player's y_speed
	move_x = move_x + jump_speed*cos(jump_direction)
	move_y = -jump_speed*sin(jump_direction);
	
	// DEBUGGING PURPOSES: Mark the player's current x and y coordinates. 
	// If the player falls off-screen, we will return them to these coordinates.
	safe_x = x;
	safe_y = y;

// If the player starts jumping while in wallclimb mode...
} else if (_jump && movement_mode == "wallclimb") {
	
	// Has the player let go of the jump key yet? Obviously no at this point.
	jump_stopped = false;
	
	// Switch back to normal movement mode...
	movement_mode = "normal";
	
	// Nudge the player a bit so they're free from the walls
	x = x - wallclimb_direction*2;
	
	// Make the player jump at an appropriate angle
	move_x = (jump_speed+walljump_bonus_speed)*cos(jump_direction);
	move_y = -(jump_speed+walljump_bonus_speed)*sin(jump_direction);
	
// If the player grabs onto a ledge...
} else if (_hold_space && _climb_collision != noone && movement_mode == "normal" && air_time > 1) {
	
	movement_mode = "grab";
	
	// Which direction will we climb in?
	if _climb_collision.image_index == 1 {
		// Climbing to the left
		grab_direction = -1;
	} else if _climb_collision.image_index == 2 {
		// Climbing to the right
		grab_direction = 1;
	}
	
	// Determine the position that the player should start climbing from
	start_x = _climb_collision.x+8 + 2*grab_direction;
	start_y = _climb_collision.y+8 + 2;
// If the player continues their jump
} else if _hold_space && movement_mode == "normal" && !_ground_collision && !jump_stopped && air_time < max_jumptime {
	// Ignore the effects of gravity for the duration the spacebar is held down
	move_y -= ((30 - air_time)/30)*grav;

// If the player lands at a wall (say for wall-climbing)...
} else if ((_wall_collision_left || _wall_collision_right) && movement_mode == "normal" && !_ground_collision) {
	movement_mode = "wallclimb";
	
	if _wall_collision_left != noone {	
		jump_direction = pi/4;
		wallclimb_direction = -1;
	} else {
		jump_direction = 3*pi/4;
		wallclimb_direction = 1;
	}
}

// AUTO CHECKS

// If the player is walking on a slope, ensure that they "adhere" to that slope
if place_meeting(x, y + slope_max, obj_collision_slope) and move_y >= 0 {
	while !place_meeting(x,y+1, obj_collision_parent) {
		y = y+1;	
	}
}

if movement_mode == "grab" {
	// toss out the move_x & move_y calculations, we don't need those in this mode
	move_x = 0;
	move_y = 0;
	
	// Update the climbing mode timer
	grab_time += 1;
} else {
	grab_time = 0;	
}

if movement_mode == "wallclimb" {
	
	// toss out the move_x calculation, we don't need it in this mode
	move_x = 0;
	
	// It's slippery holding onto walls!
	move_y = (1/16)*move_speed;
	
	// Update the climbing mode timer
	wallclimb_time += 1;	
	
	// It is possible the player might slip off of walls while in wallclimb mode.
	// Check that there is still a collision of sorts and return to normal mode if there is none.
	if !( place_meeting(x+8,y, obj_wallclimb) || place_meeting(x-8,y, obj_wallclimb) ) {
		movement_mode = "normal";	
	}	
	
	// The player needs to actually "hold" himself to the wall to stay on it!
	if sign(_move_input) != wallclimb_direction {
		movement_mode = "normal";
		x = x - 2*wallclimb_direction;
	}
	
} else {
	wallclimb_time = 0;
}

if movement_mode == "normal" && !_ground_collision {
	air_time += 1;	
} else {
	air_time = 0;	
}

var _arr = move_and_collide(move_x, move_y, obj_collision_parent, 1);

// Ensure that the player does not fall through objects
if (array_length(_arr) != 0 and place_meeting(x,y+move_y, obj_collision_parent)) {
	move_y = 0;	
}

// Check if the player is on screen. If not, respawn them at the last known safe point
if instance_exists(obj_player) {
	if obj_player.x < 0 or obj_player.x > room_width or obj_player.y < 0 or obj_player.y > room_height {
		x = safe_x;
		y = safe_y;
	}
}

// SPRITE DISPLAY CODE

// Ensure the sprite faces in the correct direction of movement...
if movement_mode == "grab" {
	image_xscale = grab_direction;
} else if movement_mode == "wallclimb" {
	image_xscale = wallclimb_direction;
} else if (move_x != 0) {
	image_xscale = sign(move_x);
}

// Display the appropriate sprite for the player...
// Is the player currently grabbing onto a ledge?
if movement_mode == "grab" {
	// Yes, they are currently grabbed onto a ledge
	// We will display a certain sprite in the climb animation depending on how they've spent in climbing mode
	sprite_index = spr_player_climb;
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
		grab_time = 0;
		movement_mode = "normal";
	}
	
// Is the player currently wallclimbing?
} else if movement_mode == "wallclimb" {
	// Yes, they are currently wallclimbing.
	sprite_index = spr_player_wallland;
	if wallclimb_time < 2 {
		image_index = 0;
		sprite_set_speed(spr_player_wallland, 30, spritespeed_framespersecond);
	} else if image_index == 5 {
		sprite_set_speed(spr_player_wallland, 0, spritespeed_framespersecond);
	}
// Is the player standing on solid ground?
} else if air_time < 2 {
	// Yes, they are...
	if move_x == 0 {
		sprite_index = spr_player_idle;
	} else {
		sprite_index = spr_player_run;
		sprite_set_speed(spr_player_run, 12*((abs(move_x)+move_speed)/(2*move_speed)), spritespeed_framespersecond);
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