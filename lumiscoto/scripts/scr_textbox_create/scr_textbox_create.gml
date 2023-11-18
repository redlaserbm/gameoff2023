// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @param _text_id
function scr_textbox_create(_text_id){
	// Generates a textbox with text that corresponds to the given _text_id
	// To modify the text that a given _text_id generates, go to scr_dialogue
	with( instance_create_depth(0,0,-16000, obj_textbox) ) {
			scr_dialogue(_text_id);
	}
}