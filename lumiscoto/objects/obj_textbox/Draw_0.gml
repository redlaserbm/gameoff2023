/// @description Insert description here
// You can write your code in this editor

accept_key = keyboard_check_pressed(ord("Z"));

var _textbox_x = camera_get_view_x(view_camera[0]);
var _textbox_y = camera_get_view_y(view_camera[0]) + 32;

// Additional setup
if !setup {
	setup = true;
	
	draw_set_font(global.font_main);
	
	// When we set a point to draw text from, we will be setting the TOP-LEFT most point of that text
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	page_number = array_length(text);
	
	for(var _p = 0; _p < page_number; _p++) {
		
		// Determine the length (in characters) of the text to be displayed for each page
		text_length[_p] = string_length(text[_p]);	
		
		// I'm following a tutorial here, but this value isn't likely to change in our implementation
		text_x_offset[_p] = 32;
	}
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
			instance_destroy();
		}
	}
}

// Draw the textbox
textbox_img += textbox_img_speed;
textbox_spr_w = sprite_get_width(textbox_spr);
textbox_spr_h = sprite_get_height(textbox_spr);

draw_sprite_ext(textbox_spr, textbox_img, _textbox_x + text_x_offset[page], _textbox_y, textbox_width/textbox_spr_w, textbox_height/textbox_spr_h, 0, c_white, 255);

// Draw the text on the textbox
var _drawtext = string_copy(text[page], 1, draw_char);
draw_set_color(make_color_rgb(248,255,218));
draw_text_ext(_textbox_x + text_x_offset[page] + border, _textbox_y + 0 + border, _drawtext, line_sep, line_width);







