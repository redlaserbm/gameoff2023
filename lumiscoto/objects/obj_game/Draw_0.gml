/// @description Insert description here
// You can write your code in this editor
var _zero_x = camera_get_view_x(view_camera[0]);
var _zero_y = camera_get_view_y(view_camera[0]);

draw_text(_zero_x, _zero_y, string(obj_player.move_x));
draw_text(_zero_x, _zero_y + 32, string(obj_player.colliding));
draw_text(_zero_x, _zero_y + 64, string(obj_player.air_time));
draw_text(_zero_x, _zero_y + 96, string(obj_player.movement_mode));
draw_text(_zero_x, _zero_y + 128, string(obj_player.jump_direction));


