/datum/mood_event/New(mob/M, ...)
	. = ..()
	for(var/datum/macrogame_gamemode/running_gamemode in SSmacrogames.running_gamemodes)
		if(running_gamemode.anull_negative_moodles && (mood_change < 0))
			mood_change = 0
			break

/datum/mood_event/tucked_in
	description = "I feel better having tucked someone in for a good night's rest!"
	mood_change = 3
	timeout = 2 MINUTES

/datum/mood_event/tucked_in/add_effects(mob/tuckee)
	if(!tuckee)
		return
	description = "I feel better having tucked in [tuckee.name] for a good night's rest!"
