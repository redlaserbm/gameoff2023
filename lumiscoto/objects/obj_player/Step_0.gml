/// @description Insert description here
// You can write your code in this editor

// get input
move_input = keyboard_check(vk_right) - keyboard_check(vk_left);
up_input = keyboard_check(vk_up);
jump = keyboard_check_pressed(vk_space);
hold_space = keyboard_check(vk_space);
jump_release = keyboard_check_released(vk_space);
walk = keyboard_check(vk_shift);

// Destroy *all* instances of obj_jump if the player is descending
if move_y > 0 {
	for (var _i = 0; _i < instance_number(obj_jump); ++_i;)
	{
		instance_destroy(instance_find(obj_jump,_i));
	}
}

// Execute script code
state_execute();