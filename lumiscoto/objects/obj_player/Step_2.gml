/// @description Insert description here
// You can write your code in this editor

if place_meeting(x,y,obj_collision_parent) && state_name == "Normal" {
	colliding = true;
	//Check if the collision occurs because the player being "stuck" to an object below it...
	if not place_meeting(x,y-2,obj_collision_parent) {
		y = y-2;
	}
} else {
	colliding = false;	
}

state_update();

