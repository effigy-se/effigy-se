//Add a cooldown for the character directory to the client, primarily to stop server lag from refresh spam
/client
	COOLDOWN_DECLARE(char_directory_cooldown)

//Make a verb to open the character directory
/client/verb/show_character_directory()
	set name = "Character Directory"
	set category = "OOC"
	set desc = "Shows a listing of all active characters, along with their associated OOC notes, flavor text, and more."

	// This is primarily to stop malicious users from trying to lag the server by spamming this verb
	if(!COOLDOWN_FINISHED(src, char_directory_cooldown))
		to_chat(src, span_warning("Directory refresh on cooldown!"))
		return
	COOLDOWN_START(src, char_directory_cooldown, 10 SECONDS)

//Check if there's not already a character directory open; open a new one if one is not present
	if(!GLOB.character_directory)
		GLOB.character_directory = new
	GLOB.character_directory.ui_interact(mob)
