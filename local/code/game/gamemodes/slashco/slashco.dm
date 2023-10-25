/datum/game_mode/slashco

/datum/game_mode/slashco/New()
	. = ..()

/datum/game_mode/slashco/pre_setup()
	return TRUE

/datum/game_mode/slashco/post_setup(report)
	return ..()
