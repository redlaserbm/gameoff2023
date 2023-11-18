/// @description Insert description here
// You can write your code in this editor

// Setting up the camera
global.camera = camera_create_view(0,1500,800,450);
camera_set_view_border(global.camera, 400, 200);
camera_set_view_target(global.camera, obj_player);
camera_set_view_speed(global.camera, 400, 400);

view_enabled = true;
view_visible[0] = true;
view_set_camera(0,global.camera);









