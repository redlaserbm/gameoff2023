/// @description Initialization
depth = -1;

// Influences how fast the player gets up to top speed and stops from top speed
move_accel = 0.4;
move_decel = 0.2;

move_speed = 3;
walk_speed = 1.5;
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
// Depending on the movement mode, this angle may change!
jump_direction = pi/2;

// Variable to measure whether a jump is active or not
jump_active = false;

// Variable to determine whether a walk is active or not
walk_active = false;

// Measures how long the player has spent in the air
air_time = 0;

// When the grabbing animation starts, we use these variables to define where the player should begin climbing from
start_x = x;
start_y = y;

move_x = 0;
move_y = 0;

coyote_time = 10;
max_jumptime = 10;

jump_stopped = false;

colliding = false;

// Move inputs...
move_input = false;
up_input = false;
jump = false;
hold_space = false;
jump_release = false;
walk = false;

// Is the player dead?
player_died = false;

// Setup machine state for the player
state_machine_init();

// Define the states that the player will use during the game and scripts associated with each state
state_create("Normal", ps_normal);
state_create("Grab", ps_grab);
state_create("Wallclimb", ps_wallclimb);

//Set the default state
state_init("Normal");

