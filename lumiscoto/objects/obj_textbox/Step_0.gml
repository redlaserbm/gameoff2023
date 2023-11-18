/// @description Insert description here
// You can write your code in this editor

up_down_input = keyboard_check_pressed(vk_down) - keyboard_check_pressed(vk_up);

option_pos = option_pos + up_down_input;
option_pos = clamp(option_pos,0,array_length(option) - 1);












