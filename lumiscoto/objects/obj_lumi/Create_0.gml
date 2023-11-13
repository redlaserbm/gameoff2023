/// @description Insert description here
// You can write your code in this editor

x_distance_to_player = 0;

on_the_ground = false;

jump_timer = 100;

jump_collision = noone;









// Inherit the parent event
event_inherited();

state_create("Lumi", ps_normal_lumi);
state_switch("Lumi");