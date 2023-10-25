/obj/effect/landmark/slashco_item_spawn
	name = "SlashCo Item spawn"
	icon_state = "x4"

/obj/effect/landmark/slashco_item_spawn/Initialize(mapload)
	..()
	GLOB.slashitemstart += loc
	return INITIALIZE_HINT_QDEL
