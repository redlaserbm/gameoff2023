/// @description Variable initialization

depth = -16000;

textbox_width = 32*23;
textbox_height = 32*4;

// Unlike in that tutorial, we need separate variables for the x and y borders
text_border_x = 48;
text_border_y = 44;

portrait_border_x = 32;
portrait_border_y = 8;

// This is so that we don't try to draw the text on top of the portrait
portrait_width = 128;

line_sep = 32; // Admittedly I'm not sure how to set this number, this is just a good guess rn...
line_width = textbox_width - text_border_x - text_border_y - portrait_width;

// Set the sprite to use for the textbox, as well as the image from that sprite to use and how fast it should animate...
textbox_spr = spr_textbox_back;
textbox_img = 0;
textbox_img_speed = 6/60;

textbox_spr_w = 0;
textbox_spr_h = 0;

// Set the sprite to use for the textbox portrait
portrait_spr = spr_portrait_scoto;

// the text
page = 0;
page_number = 0;

// LASER NOTE: When using scr_text, this line gets overwritten. It's just here so the compiler doesn't get mad at us.
text[0] = "text";

// Options
option[0] = "Yes";
option[1] = "No";

option_link_id[0] = -1;
option_link_id[1] = -1;

option_pos = 0;
option_number = 0;

// LASER NOTE: I'll try to implement the below so I only need to designate the portrait and emotion sprites when they need to change!

// This is an array containing the portrait sprites to be used for each given line of text above
portrait[0] = spr_portrait_scoto;

// This array contains the image_index within each sprite that should be used for the given portrait sprite
portrait_image[0] = 0;

text_length[0] = string_length(text[0]);
draw_char = 0;

text_speed = 1;

setup = false;

accept_key = false;










