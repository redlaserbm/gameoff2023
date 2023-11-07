/// @description Insert description here
// You can write your code in this editor

bg[0] = layer_get_id("bg_1");
bg[1] = layer_get_id("bg_2");
bg[2] = layer_get_id("bg_3");
bg[3] = layer_get_id("bg_4");

for (var _i = 0; _i < array_length(bg); _i++) {
	layer_x(bg[_i], lerp(0, camera_get_view_x(view_camera[0]), 1/((_i+3)*(_i+3)) ) );
	layer_y(bg[_i], camera_get_view_y(view_camera[0]));
}



