// I've granularized this override since all the other signs we overrode were implemented upstream. Ish.
/obj/structure/sign/nanotrasen
	icon = 'local/icons/obj/signs.dmi'

// this is buildable as a treat. if it's moved off this event it shouldn't be though
/obj/structure/sign/syndicate
	name = "\improper Syndicate logo sign"
	sign_change_name = "Corporate Logo - Syndicate"
	desc = "A sign with the Syndicate logo on it. Death to Nanotrasen! Just don't say that aloud..."
	icon = 'local/icons/obj/signs.dmi'
	icon_state = "syndicate"
	is_editable = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/syndicate, 32)

/obj/structure/sign/construction
	name = "UNDER CONSTRUCTION"
	sign_change_name = "Under Construction"
	desc = "A sign with a little worker shovelling a nondescript mound. Work was being done here..."
	icon = 'local/icons/obj/signs.dmi'
	icon_state = "construction"
	is_editable = TRUE

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/sign/construction, 32)
