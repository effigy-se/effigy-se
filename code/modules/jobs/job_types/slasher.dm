/datum/job/slasher
	title = JOB_SLASHER

/datum/job/slasher/after_roundstart_spawn(mob/living/spawning, client/player_client)
	. = ..()
	var/datum/antagonist/slasher/slasher_antag = spawning.mind.has_antag_datum(/datum/antagonist/slasher)
	if(!slasher_antag)
		CRASH("player occupying slasher job without antag datum")
	slasher_antag.equip_slasher()
