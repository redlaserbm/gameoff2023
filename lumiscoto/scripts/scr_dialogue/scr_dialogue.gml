// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @param _text_id
function scr_dialogue(_text_id){
	
	switch(_text_id) {
		case "":
			scr_text("Laser please add details.");
			break;
		case "solitude":
			// Initial Dialogue
			scr_text("Hello there fellow traveler...");
			scr_text("Do you know the route from which you came from?");
			
			// Branching dialogue
			scr_option("Yes, I do.", "solitude_yes");
			scr_option("No, I don't.", "solitude_no");
			break;
			
			case "solitude_yes":
				scr_text("Are you sure? You seem a bit too human to know your way around these parts...");
				break;
			case "solitude_no":
				scr_text("Such is the plight of all who find themselves in this predicament...");
				break;
	}
}