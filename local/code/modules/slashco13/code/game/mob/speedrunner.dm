/mob/living/basic/slasher/speedrunner
	name = "Speedrunner"
	desc = "The Speed Slasher whose speed grows at a constant rate over time."
	icon = 'local/code/modules/slashco13/icons/mob/slasherstall.dmi'
	icon_state = "speedrunner"

/mob/living/basic/slasher/speedrunner/get_status_tab_items()
	. = ..()
	for(var/datum/antagonist/slasher/speedrunner/our_slasher in mind?.antag_datums)
		. += "Phase: [our_slasher.current_phase]"
		. += "Movespeed: [our_slasher.chase_movespeed_mod]"
		. += "Movespeed Limit: [our_slasher.current_movespeed_limit]"
