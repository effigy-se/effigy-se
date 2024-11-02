/mob/living/basic/slasher/dolphinman
	name = "Dolphinman"
	desc = "The Patient Slasher who waits for survivors to come to him."
	icon_state = "dolphinman"

/mob/living/basic/slasher/dolphinman/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/footstep, FOOTSTEP_IMPOSTER)
	START_PROCESSING(SSprocessing, src)

/mob/living/basic/slasher/dolphinman/process(seconds_per_tick)
	for(var/datum/antagonist/slasher/dolphinman/our_slasher in mind?.antag_datums)
		if(our_slasher.hiding) // We're trying to hide
			our_slasher.time_to_add += seconds_per_tick
			for(var/mob/living/to_check in viewers(DEFAULT_SIGHT_DISTANCE, src))
				if(to_check.client && !to_check?.mind?.antag_datums) // Someone not an antag AND who has a client saw us; abort
					SetParalyzed(0, TRUE)
					our_slasher.banked_time += our_slasher.time_to_add
					our_slasher.time_to_add = 0
					our_slasher.hiding = FALSE
					return PROCESS_KILL

/mob/living/basic/slasher/dolphinman/proc/toggle_hide()
	for(var/datum/antagonist/slasher/dolphinman/our_slasher in mind?.antag_datums)
		if(our_slasher.is_chasing)
			return // Fuck off!
		if(our_slasher.hiding)
			SetParalyzed(0, TRUE)
			if(istype(src, our_slasher.mob_type))
				our_slasher.banked_time = (our_slasher.time_to_add * 0.5) // You quit early; get half the prize
				our_slasher.hiding = FALSE
			return
		Paralyze(INFINITY, TRUE)
		if(istype(src, our_slasher.mob_type))
			our_slasher.hiding = TRUE
