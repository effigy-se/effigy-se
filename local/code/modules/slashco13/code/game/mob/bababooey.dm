/mob/living/basic/slasher/bababooey
	name = "Bababooey"
	desc = "The Phantom Slasher which specialises in illusion abilities to catch survivors off-guard."
	icon_state = "bababooey"
	var/currently_cloaked = FALSE

	var/datum/looping_sound/bababooey_laughs/our_laughs
	var/datum/looping_sound/bababooey_breaths/our_breathing

/mob/living/basic/slasher/bababooey/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/footstep, FOOTSTEP_BABABOOEY)
	our_laughs = new
	our_breathing = new
	var/datum/action/cooldown/bababooey_toggle_invisibility/toggle_invis = new
	var/datum/action/cooldown/bababooey_create_clone/create_clone = new
	toggle_invis.Grant(src)
	create_clone.Grant(src)

/mob/living/basic/slasher/bababooey/Destroy()
	QDEL_NULL(our_laughs)
	QDEL_NULL(our_breathing)
	return ..()

/mob/living/basic/slasher/bababooey/proc/bababooey_cloak()
	pass_flags = PASSMOB
	invisibility = INVISIBILITY_OBSERVER
	can_jumpscare = FALSE
	currently_cloaked = TRUE
	density = FALSE
	for(var/datum/antagonist/slasher/bababooey/gotcha in mind?.antag_datums)
		gotcha.our_chase_attack.Remove(src)
	RemoveElement(/datum/element/footstep, FOOTSTEP_BABABOOEY)
	animate(src, 1 SECONDS, alpha = 127.5)
	playsound(get_turf(src), 'local/code/modules/slashco13/sound/slasher/bababooey/bababooey.ogg', 75)
	playsound(get_turf(src), 'local/code/modules/slashco13/sound/slasher/bababooey/hide.ogg', 100)
	our_laughs.start(src)
	our_breathing.start(src)

/mob/living/basic/slasher/bababooey/proc/bababooey_uncloak()
	pass_flags = NONE
	invisibility = INVISIBILITY_NONE
	Paralyze(1 SECONDS, TRUE) // No cheesing this out
	can_jumpscare = TRUE
	currently_cloaked = FALSE
	density = TRUE
	for(var/datum/antagonist/slasher/bababooey/gotcha in mind?.antag_datums)
		gotcha.our_chase_attack.Grant(src)
	AddElement(/datum/element/footstep, FOOTSTEP_BABABOOEY)
	animate(src, 1 SECONDS, alpha = 255)
	playsound(get_turf(src), 'local/code/modules/slashco13/sound/slasher/bababooey/reveal.ogg', 100)
	our_laughs?.stop(FALSE)
	our_breathing?.stop(FALSE)

/*
	TOGGLE INVISIBILITY
*/

/datum/action/cooldown/bababooey_toggle_invisibility
	name = "Toggle Invisibility"
	desc = "Dissapear into the aether - or manifest; to attack your victims."
	background_icon = 'local/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_slasher"
	button_icon = 'local/icons/mob/actions/actions_slashers.dmi'
	button_icon_state = "cloak"
	overlay_icon = 'local/icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_slasher_border"
	cooldown_time = 5 SECONDS

/datum/action/cooldown/bababooey_toggle_invisibility/Activate(atom/target)
	. = ..()
	if(istype(owner, /mob/living/basic/slasher/bababooey))
		var/mob/living/basic/slasher/bababooey/our_owner = owner
		if(our_owner.currently_cloaked)
			our_owner.bababooey_uncloak()
		else
			our_owner.bababooey_cloak()

/// Invisibility Looping Sounds

/datum/looping_sound/bababooey_laughs
	start_sound = null
	start_length = 5 SECONDS
	mid_sounds = list(
		'local/code/modules/slashco13/sound/slasher/bababooey/laugh1.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/laugh2.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/laugh3.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/laugh4.ogg' = 1, \
		)
	mid_length = 14 SECONDS
	end_sound = null
	volume = 65

/datum/looping_sound/bababooey_breaths
	start_sound = null
	start_length = 1
	mid_sounds = list(
		'local/code/modules/slashco13/sound/slasher/bababooey/breathing/01Breathing.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/breathing/02Breathing.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/breathing/03Breathing.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/breathing/04Breathing.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/breathing/05Breathing.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/breathing/06Breathing.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/breathing/07Breathing.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/breathing/08Breathing.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/breathing/09Breathing.ogg' = 1, \
		'local/code/modules/slashco13/sound/slasher/bababooey/breathing/10Breathing.ogg' = 1, \
		)
	mid_length = 1 SECONDS
	end_sound = null
	volume = 10
	direct = TRUE

/*
	CLONE STUFF
*/

/datum/action/cooldown/bababooey_create_clone
	name = "Create Clone"
	desc = "Lay a clone to scare your victims - and alert you to their whereabouts..."
	background_icon = 'local/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_slasher"
	button_icon = 'local/icons/mob/actions/actions_slashers.dmi'
	button_icon_state = "clone"
	overlay_icon = 'local/icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_slasher_border"
	cooldown_time = 5 SECONDS
	var/mob/living/basic/slasher/bababooey/clone/created_clone

/datum/action/cooldown/bababooey_create_clone/Activate(atom/target)
	. = ..()
	if(created_clone != null)
		owner.balloon_alert(owner, "already have one!")
		return
	created_clone = new(get_turf(owner))

/datum/action/cooldown/bababooey_create_clone/Destroy()
	QDEL_NULL(created_clone)
	return ..()

/mob/living/basic/slasher/bababooey/clone
	invisibility = INVISIBILITY_OBSERVER
	pass_flags = PASSMOB
	density = FALSE
	can_jumpscare = FALSE
	alpha = 127.5
	currently_cloaked = TRUE
	move_force = MOVE_FORCE_OVERPOWERING
	move_resist = MOVE_FORCE_OVERPOWERING
	pull_force = MOVE_FORCE_OVERPOWERING
	///Proximity monitor associated with this atom, needed for proximity checks.
	var/datum/proximity_monitor/proximity_monitor
	var/unfound = TRUE

/mob/living/basic/slasher/bababooey/clone/Initialize(mapload)
	. = ..()
	proximity_monitor = new(src, 3)

/mob/living/basic/slasher/bababooey/clone/HasProximity(atom/movable/proximity_check_mob)
	if(isliving(proximity_check_mob) && unfound)
		var/mob/living/proxed_mob_found = proximity_check_mob
		if(proxed_mob_found.mind && proxed_mob_found.mind.antag_datums == null) // Not an antag and actually a player; alert the bababooey legion
			unfound = FALSE
			for(var/datum/antagonist/slasher/bababooey/found_bababooey in GLOB.antagonists)
				found_bababooey?.owner?.current?.balloon_alert(found_bababooey?.owner?.current, "clone activated!")
			bababooey_uncloak()
			playsound(get_turf(src), 'local/code/modules/slashco13/sound/slasher/bababooey/scare.ogg', 75)
			QDEL_IN(src, 5 SECONDS)
