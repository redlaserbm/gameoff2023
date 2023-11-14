/// @description Insert description here
// You can write your code in this editor

// get input
up_input = 0;
jump = 0;
walk = 1;
hold_space = 0;
jump_release = 0;


// Check Lumi's distance to the player. If Lumi is too far away, have her move closer to the player
// LASER'S NOTE: move_input here works similarly to how it works with obj_player, except here we are *automatically* controlling the value of move_input

if on_the_ground {
	// Don't update this variable unless lumi is on the ground
	x_distance_to_player = obj_player.x - obj_lumi.x;
}

if abs(x_distance_to_player) > 24 {
	//Is the player to our left or our right?
	if x_distance_to_player > 0 {
		// The player is to the RIGHT of Lumi	
		move_input = 1;
	} else {
		// The player is to the LEFT of Lumi
		move_input = -1;
	}
} else {
	move_input = 0;	
};

// Should Lumi walk or run?
if abs(x_distance_to_player) > 48 {
	walk = false;	
} else {
	walk = true;	
}

// Jumping
jump_collision = instance_place(x,y, obj_jump);
if jump_collision != noone {
	if jump_collision.image_index == 0 {
		jump = 1;
		jump_timer = 0;
	} else {
		jump = 0;	
	}
}

jump_timer += 1;
if jump_timer >= max_jumptime {
	jump = 0;
}

// Execute script code
state_execute();









