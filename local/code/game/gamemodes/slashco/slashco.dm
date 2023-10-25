/datum/game_mode/slashco
	var/list/slasher_types

/datum/game_mode/slashco/New()
	. = ..()
	slasher_types = subtypesof(/datum/slasher_types)

/datum/game_mode/slashco/pre_setup()
	return TRUE

/datum/game_mode/slashco/post_setup(report)
	return ..()
