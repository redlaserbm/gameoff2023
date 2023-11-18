// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_find_lumiscoto(){
	// This script identifies the instance id's of lumi and scoto and is intended to be used by obj_game and stored in it
	
	// Thankfully, there's only one instance of lumi on screen ever
	id_lumi = instance_find(obj_lumi,0).id;
	
	// Iterate through both obj_player objects...
	for (var _i = 0; _i < instance_number(obj_player); _i++) {
		// Is the given instance an instance of lumi or an instance of scoto?
		var _id_of_interest = instance_find(obj_player,_i).id;
		if _id_of_interest != id_lumi {
			// It's Scoto
			id_scoto = _id_of_interest;
		}
	}
}