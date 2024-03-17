/obj/machinery/status_display/random_message/motivational
	name = "motivational display"
	desc = "They got tired of licensing stock photos for these; but on they're upshot, now they're DIGITAL! The future is here, and you're on the bleeding edge of progres..."

/obj/machinery/status_display/random_message/Initialize(mapload, ndir, building)
	// "Motivation" is stored in the strings folder
	firstline_to_secondline = world.file2list("local/strings/motivational_display_quotes.txt")
	. = ..()
