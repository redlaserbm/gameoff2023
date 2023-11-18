// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_check_scoto(){
	var _ins = obj_game.id_scoto;
	var _val = false;
	if _ins.state_name == "Normal" && _ins.move_y == 0 && distance_to_object(_ins) < 32 {
		_val = true;
	}
	
	return _val;
}