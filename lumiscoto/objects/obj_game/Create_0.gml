/// @description Insert description here
// You can write your code in this editor

// This array is used for the parralax scrolling code in the step event
bg = array_create(4, noone);

// Sets the font to use for text display
global.font_main = fnt_wildwords;

// The idea here is for the player to either be able to move using the arrow keys or the WASD keys if they wish...
ctrl_mode[0] = "WASD";
ctrl_mode[1] = "KEYS";

// This variable controls the actual movement mode the player uses.
ctrl_mode_index = 0;

id_lumi = noone;
id_scoto = noone;

scr_find_lumiscoto();

