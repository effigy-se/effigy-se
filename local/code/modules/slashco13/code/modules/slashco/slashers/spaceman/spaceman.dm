/// tl;dr; this is the SC13 analogue to SlashCo's Tyler; rethemed because I specifically did not want to deal with any copyright shenanigans
/// as a result little other than the general mechanical concept survives from the OG implementation
/datum/antagonist/slasher/spaceman
	name = "\improper Spaceman"
	mob_type = /mob/living/basic/slasher/spaceman
	start_with_chase = FALSE
	jumpscare_time = 1 SECONDS
	jumpscare_sound = 'sound/effects/adminhelp.ogg'
	jumpscare_volume = 100 // hey; got a minute?
	jumpscare_icon = 'local/code/modules/slashco13/icons/ui/jumpscares/spaceman.dmi'
	jumpscare_icon_state = "spaceman"
	ui_name = "AntagInfoSpaceman"
	fluff = "You're a relic from an era gone by."

	chase_light_range = 14 // Pray he doesn't find you

	/// Are we currently playing music?
	var/playing_some_tunes = FALSE

	/// If TRUE; killing won't end your active phase. Used specifically for the shuttle call
	var/permanent_active_phase = FALSE

	/// If TRUE; we're in our active phase
	var/active_phase = FALSE

	/// Our songs
	var/datum/looping_sound/spaceman_music/title_zero
	var/datum/looping_sound/spaceman_music/title_two/title_two
	var/datum/looping_sound/spaceman_music/title_three/title_three

	var/datum/action/cooldown/spaceman_manifest/manifest_ability

/datum/antagonist/slasher/spaceman/give_slasher_abilities()
	. = ..()
	title_zero = new
	title_two = new
	title_three = new
	manifest_ability = new
	manifest_ability.Grant(owner.current)

/// Since spaceman spawning invariably means that more gas cans get injected into the round; we need to delete some we spawned roundstart to compensate
/datum/antagonist/slasher/spaceman/map_specific_setup()
	. = ..()
	var/list/all_fuel = list()
	for(var/obj/item/stack/fuel/to_snipe in world)
		all_fuel += to_snipe
	if(all_fuel) // possible we went through it all already if multiple spacemen spawned
		for(var/integer=1 to round(all_fuel.len * 0.5))
			qdel(pick_n_take(all_fuel))

/// We got interrupted by something while the do_after was running; skedaddle
/datum/antagonist/slasher/spaceman/proc/cancel_the_kill()
	owner.current.invisibility = initial(owner.current.invisibility)
	owner.current.pass_flags = initial(owner.current.pass_flags)
	owner.current.set_anchored(FALSE)
	animate(owner.current, 1 SECONDS, alpha = initial(owner.current.alpha))
	to_chat(owner.current, span_cult("You're interuptted. You fade away; leaving behind fuel in the process..."))
	playsound(get_turf(owner.current), 'local/code/modules/slashco13/sound/slasher/spaceman/create.ogg', 100)
	new /obj/item/stack/fuel(get_turf(owner.current))

/// We succeeded the do after.. ascend
/datum/antagonist/slasher/spaceman/proc/tc_trade_for_antag()
	if(active_phase) // Something's fucked up
		return
	active_phase = TRUE
	our_chase_music.start(owner.current)
	owner.current.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/slasher_chase, multiplicative_slowdown = -2) // get them. GET THEM ALL
	if(istype(owner.current, /mob/living/basic/slasher))
		var/mob/living/basic/slasher/to_gamer = owner.current
		to_gamer.can_jumpscare = TRUE
	owner.current.set_light(l_range = chase_light_range, l_color = chase_color)
	owner.current.set_anchored(FALSE)

/// Jumpscare landed! Reset for next go around
/datum/antagonist/slasher/spaceman/prank_em_john(mob/living/target)
	. = ..()
	if(!permanent_active_phase)
		active_phase = FALSE
		our_chase_music.stop(owner.current)
		owner.current.remove_movespeed_modifier(/datum/movespeed_modifier/slasher_chase)
		if(istype(owner.current, /mob/living/basic/slasher))
			var/mob/living/basic/slasher/to_gamer = owner.current
			to_gamer.can_jumpscare = FALSE
		owner.current.set_light(l_range = initial(owner.current.light_range), l_color = NONSENSICAL_VALUE)
		owner.current.invisibility = initial(owner.current.invisibility)
		owner.current.pass_flags = initial(owner.current.pass_flags)
		animate(owner.current, 1 SECONDS, alpha = initial(owner.current.alpha))

/*
	MANIFEST
*/

/datum/action/cooldown/spaceman_manifest
	name = "Manifest"
	desc = "Root yourself in place; and pray none of your prey find you."
	background_icon = 'local/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_slasher"
	button_icon = 'local/icons/mob/actions/actions_slashers.dmi'
	button_icon_state = "manifest"
	overlay_icon = 'local/icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_slasher_border"
	cooldown_time = 5 SECONDS

/datum/action/cooldown/spaceman_manifest/Activate(atom/target)
	. = ..()
	for(var/datum/antagonist/slasher/spaceman/our_slasher in owner?.mind?.antag_datums)
		if(our_slasher.active_phase || our_slasher.playing_some_tunes)
			return // Nothing to be done here; go kill someone boss
		if(!isopenturf(get_turf(owner)) || ischasm(get_turf(owner)) || islava(get_turf(owner)))
			return // please fuck off for even trying this
		our_slasher.playing_some_tunes = TRUE
		owner.invisibility = INVISIBILITY_NONE
		owner.pass_flags = NONE
		animate(owner, 1 SECONDS, alpha = 255)
		owner.set_anchored(TRUE)
		owner.density = TRUE
	if(istype(owner, /mob/living/basic/slasher/spaceman))
		var/mob/living/basic/slasher/spaceman/our_mob = owner
		our_mob.do_ascend()
