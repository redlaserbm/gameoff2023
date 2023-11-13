/// @description Insert description here
// You can write your code in this editor

// get input
move_input = keyboard_check(vk_right) - keyboard_check(vk_left);
up_input = keyboard_check(vk_up);
jump = keyboard_check_pressed(vk_space);
hold_space = keyboard_check(vk_space);
jump_release = keyboard_check_released(vk_space);

// Execute script code
state_execute();