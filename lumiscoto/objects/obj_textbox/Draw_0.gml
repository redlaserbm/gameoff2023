/// @description Insert description here
// You can write your code in this editor

accept_key = keyboard_check_pressed(ord("Z"));

var _textbox_x = camera_get_view_x(view_camera[0]);
var _textbox_y = camera_get_view_y(view_camera[0]);

// Additional setup
if !setup {
	setup = true;
	
	draw_set_font(global.font_main);
	
	cursor_space = string_width("> ");
	
	// When we set a point to draw text from, we will be setting the TOP-LEFT most point of that text
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	for(var _p = 0; _p < page_number; _p++) {
		
		// Determine the length (in characters) of the text to be displayed for each page
		text_length[_p] = string_length(text[_p]);	
	}
	
	option_number = array_length(option);
	for(var _p = 0; _p < option_number; _p++) {
		// Determine the width of the textbox that will host the dialogue options
		if string_width(option[_p]) > option_width {
			option_width = string_width(option[_p]);
		}
	}
	// Don't forget to give the text some breathing room!
	option_width += 2*option_border_x + cursor_space;
	
	// How high should the options textbox be?
	option_height = 2*text_border_y + line_sep*(array_length(option)-1) + string_height(option[array_length(option)-1]);
}

// Typewriter effect
if draw_char < text_length[page] {
	draw_char += text_speed;
	draw_char = clamp(draw_char, 0, text_length[page]); 
}

// Flip through pages
if accept_key {
	// Has all the text for the current page displayed yet?
	if draw_char < text_length[page] {
		// No. This skips the typing effect and writes out all the text immediately
		draw_char = text_length[page];
	}
	else {
		// Yes. Go to the next page of text if it exists, or else destroy the textbox.
		if page < page_number - 1 {
			page++;
			draw_char = 0;
		} else {
			// We have scrolled through all the text the textbox has to offer
			
			// Did the textbox have any branching options?
			if option_link_id[0] == noone {
				// No, it didn't. Destroy the textbox.
				instance_destroy();
			} else {
				// Yes, it did! Create the new textbox, then destroy this one
				scr_textbox_create(option_link_id[option_pos]);
				instance_destroy();
			}
		}
	}
}

// Options
if (page == page_number - 1) && (draw_char == text_length[page]) && option_link_id[0] != noone {
	
	// Draw the textbox
	draw_sprite_ext(textbox_spr, textbox_img, _textbox_x + option_x_offset - option_width, _textbox_y + option_y_offset, option_width/textbox_spr_w, option_height/textbox_spr_h, 0, c_white, 255);

	// Draw the text on the textbox
	var _nudge = 0;
	for(var _i = 0; _i < array_length(option); _i++) {
		var _drawoption = option[_i];
		if option_pos == _i {
			draw_text_ext(_textbox_x + option_x_offset + option_border_x - option_width, _textbox_y + option_y_offset + text_border_y + _nudge, string_concat("> ", _drawoption), line_sep, line_width);
		} else {
			draw_text_ext(_textbox_x + option_x_offset + option_border_x - option_width + cursor_space, _textbox_y + option_y_offset + text_border_y + _nudge, _drawoption, line_sep, line_width);
		}
		_nudge += line_sep;
	}
	
	// Draw the cursor in the correct location depending on which option is active
}

// Draw the textbox
textbox_img += textbox_img_speed;
textbox_spr_w = sprite_get_width(textbox_spr);
textbox_spr_h = sprite_get_height(textbox_spr);

draw_sprite_ext(textbox_spr, textbox_img, _textbox_x + textbox_x_offset, _textbox_y + textbox_y_offset, textbox_width/textbox_spr_w, textbox_height/textbox_spr_h, 0, c_white, 255);
draw_sprite_ext(portrait_spr, 0, _textbox_x + portrait_border_x,  _textbox_y + portrait_border_y, 1, 1, 0, c_white, 255);

// Draw the text on the textbox
var _drawtext = string_copy(text[page], 1, draw_char);
draw_set_color(make_color_rgb(196,231,255));
draw_text_ext(_textbox_x + textbox_x_offset + text_border_x + portrait_width, _textbox_y +  textbox_y_offset + text_border_y, _drawtext, line_sep, line_width);







