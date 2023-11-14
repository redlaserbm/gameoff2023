/// @description Variable initialization

depth = -16000;

textbox_width = 32*23;
textbox_height = 32*4;
border = 32;
line_sep = 32; // Admittedly I'm not sure how to set this number, this is just a good guess rn...
line_width = textbox_width - 2*border;

// Set the sprite to use for the textbook, as well as the image from that sprite to use and how fast it should animate...
textbox_spr = spr_textbox;
textbox_img = 0;
textbox_img_speed = 6/60;

textbox_spr_w = 0;
textbox_spr_h = 0;

// the text
page = 0;
page_number = 0;
text[0] = "The pathway you seek is a pathway that no longer exists.";
text[1] = "Please heed my words. I speak my sayings with full conviction, traveler.";
text_length[0] = string_length(text[0]);
draw_char = 0;

text_speed = 1;

setup = false;

accept_key = false;










