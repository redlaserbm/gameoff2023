/// @description Insert description here
// You can write your code in this editor

// Influences how fast the player gets up to top speed and stops from top speed
move_accel = 0.4;
move_decel = 0.2;

move_speed = 3;
jump_speed = 5;
walljump_bonus_speed = 0;

// Influences how fast the player falls.
grav = 0.45;

// Some ground is slanted. This variable influences how steep ground can be before the player would be made to slip off that ground
slope_max = 8;

// If the player dies, what's a set of "safe" coordinates we can return them to?
safe_x = x;
safe_y = y;

// The player may enter various movement modes depending on the action he needs to perform
movement_mode = "normal";

// This is used to measure how long the player has spent in grabbing mode. 
// The purpose of this timer is so that we can fine-tune animations related to the pre-scripted climbing animation.
grab_time = 0;
grab_direction = 1;

// This is used to measure how long the player has spent in wallclimbing mode
wallclimb_time = 0;
wallclimb_direction = 1;

// Angle that the player will jump at, in radians...
jump_direction = pi/2;

// Measures how long the player has spent in the air
air_time = 0;

// When the climbing animation starts, we use these variables to define where the player should begin climbing from
start_x = x;
start_y = y;

move_x = 0;
move_y = 0;

coyote_time = 10;
max_jumptime = 10;

jump_stopped = false;

colliding = false;


