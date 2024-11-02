/datum/antagonist/slasher/speedrunner
	name = "\improper Speedrunner"
	mob_type = /mob/living/basic/slasher/speedrunner
	start_with_chase = FALSE // Speedrunner can't chase at all. Manhunt or something. idk
	fluff = "You're out for a manhunt..."
	ui_name = "AntagInfoSpeedrunner"
	jumpscare_icon_state = "speedrunner"
	jumpscare_sound = 'local/code/modules/slashco13/sound/slasher/speedrunner/kill.ogg'
	jumpscare_time = 1 SECONDS
	jumpscare_volume = 50
	chase_movespeed_mod = 0.75 // slowwww to start.

	chase_light_range = DEFAULT_SIGHT_DISTANCE
	chase_color = LIGHT_COLOR_VIVID_GREEN

	/// Movespeed works via negative numbers; so; uh. Awa?
	var/current_movespeed_limit = 0
	/// What's our current phase? Valid values are 1, 2, 3
	var/current_phase = 1
	/// Can we perform an RNG Sacrifice and move up a rank?
	var/can_sacrifice = FALSE
	/// Have we alerted we can sac yet?
	var/havent_sacrifice_alerted = TRUE

	var/datum/action/cooldown/rng_sacrifice/prestige_funny

/datum/antagonist/slasher/speedrunner/give_slasher_abilities()
	. = ..()
	owner.current.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/slasher_chase, multiplicative_slowdown = chase_movespeed_mod)
	prestige_funny = new
	prestige_funny.Grant(owner.current)
	RegisterSignal(owner.current, COMSIG_MOVABLE_MOVED, PROC_REF(speed_maths))

/datum/antagonist/slasher/speedrunner/proc/speed_maths()
	SIGNAL_HANDLER
	var/to_remove = get_phase_speed_formula()
	chase_movespeed_mod -= to_remove
	if(chase_movespeed_mod < current_movespeed_limit)
		chase_movespeed_mod = current_movespeed_limit
		if(!can_sacrifice && current_phase != 3 && havent_sacrifice_alerted)
			to_chat(owner.current, span_cult_bold_italic("You can feel your heart burning... your ascension incubates; and will be ready in one minute."))
			playsound(owner.current, 'sound/hallucinations/im_here2.ogg', 75)
			addtimer(CALLBACK(src, PROC_REF(set_ascend_ready)), 1 MINUTES)
			havent_sacrifice_alerted = FALSE
	owner.current.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/slasher_chase, multiplicative_slowdown = chase_movespeed_mod)
	return

/datum/antagonist/slasher/speedrunner/proc/get_phase_speed_formula()
	var/to_return
	switch(current_phase)
		if(1)
			to_return = 0.0015
		if(2)
			to_return = 0.0025
		if(3)
			to_return = 0.003
	return to_return

/datum/antagonist/slasher/speedrunner/proc/set_ascend_ready()
			can_sacrifice = TRUE
			to_chat(owner.current, span_cult_bold_italic("You can feel that it's time... you're ready to perform an RNG Sacrifice."))
			playsound(owner.current, 'sound/hallucinations/im_here2.ogg', 75)

/*
	RNG SACRIFICE
*/

/// Ups speedrunner's phase; resets him; changes his music - and triggers a random event

/datum/action/cooldown/rng_sacrifice
	name = "RNG Sacrifice"
	desc = "Ascend to a higher phase; should you have walked for long enough."
	background_icon = 'local/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_slasher"
	button_icon = 'local/icons/mob/actions/actions_slashers.dmi'
	button_icon_state = "rng_sacrifice"
	overlay_icon = 'local/icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_slasher_border"
	cooldown_time = 5 SECONDS

/datum/action/cooldown/rng_sacrifice/Activate(atom/target_atom)
	. = ..()
	for(var/datum/antagonist/slasher/speedrunner/our_slasher in owner?.mind?.antag_datums)
		if(!our_slasher.can_sacrifice)
			to_chat(owner, span_cult("You can't ascend; yet... you must walk these planes further."))
			return
		our_slasher.current_phase++
		our_slasher.can_sacrifice = FALSE
		our_slasher.our_chase_music.stop(TRUE)
		switch(our_slasher.current_phase)
			if(2)
				our_slasher.our_chase_music.start_sound = list('local/code/modules/slashco13/sound/slasher/speedrunner/Phase2/01SpeedrunnerPhase2.ogg')
				our_slasher.our_chase_music.mid_sounds = our_slasher.phase_two_mid_music
				our_slasher.our_chase_music.volume = 50
				our_slasher.current_movespeed_limit = -1
				playsound(owner, 'local/code/modules/slashco13/sound/slasher/speedrunner/rng1.ogg', 100)
			if(3)
				our_slasher.our_chase_music.start_sound = list('local/code/modules/slashco13/sound/slasher/speedrunner/Phase3/01SpeedrunnerPhase3.ogg')
				our_slasher.our_chase_music.mid_sounds = our_slasher.phase_three_mid_music
				our_slasher.our_chase_music.volume = 75
				our_slasher.current_movespeed_limit = -2 // I want you to know that if there is a god he's weeping
				owner.set_light(l_range = our_slasher.chase_light_range, l_color = our_slasher.chase_color)
				owner.icon_state = "speedrunner_ascent"
				playsound(owner, 'local/code/modules/slashco13/sound/slasher/speedrunner/rng2.ogg', 100)
		SSevents.spawnEvent() // a LITTLE SILLY
		our_slasher.chase_movespeed_mod = initial(our_slasher.chase_movespeed_mod)
		our_slasher.our_chase_music.start(owner)
		owner.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/slasher_chase, multiplicative_slowdown = our_slasher.chase_movespeed_mod)
		to_chat(owner, span_cult_bold("You ascend to phase [our_slasher.current_phase]."))
		our_slasher.havent_sacrifice_alerted = TRUE
