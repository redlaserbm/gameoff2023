// Importantly, scoto shouldn't be able to move in the game world while engaged in a battle with enemies
// I will add the check condition for this in the if loop some other time. For now...

if 1 == 1 {
	if (keyboard_check(vk_right)) {
		direction = 0;
		
		tilemap_get(tilemap, x + 16, y);
		speed = collision_check(x, y, direction, move_speed);
	}
	
	if (keyboard_check(vk_up)) {
		direction = 90;
		speed = collision_check(x, y, direction, move_speed);
	}
	
	if (keyboard_check(vk_left)) {
		direction = 180;
		speed = collision_check(x, y, direction, move_speed);
	}
	
	if (keyboard_check(vk_down)) {
		direction = 270;
		speed = collision_check(x,y, direction, move_speed);
	}
}

if speed > 0 && can_move {
	can_move = false;
	old_x = x;
	old_y = y;
}

if speed == 0 {
	sprite_index = sprite_facing[array_ind];
}
else {
	sprite_index = sprite_walking[array_ind];	
}




