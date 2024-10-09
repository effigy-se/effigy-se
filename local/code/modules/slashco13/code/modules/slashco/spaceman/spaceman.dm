/// tl;dr; this is the SC13 analogue to SlashCo's Tyler; rethemed because I specifically did not want to deal with any copyright shenanigans
/// as a result little other than the general mechanical concept survives from the OG implementation
/datum/antagonist/slasher/spaceman
	name = "\improper Spaceman"
	mob_type = /mob/living/basic/slasher/spaceman
	start_with_chase = FALSE
	jumpscare_time = 1 SECONDS
	jumpscare_sound = 'sound/effects/adminhelp.ogg'
	jumpscare_icon = null
	ui_name = "AntagInfoSpaceman"
	fluff = "You're a relic from an era gone by."

	/// Are we currently playing music?
	var/playing_some_tunes = FALSE

	/// If TRUE; killing won't end your active phase. Used specifically for the shuttle call
	var/permanent_active_phase = FALSE

/// Since spaceman spawning invariably means that more gas cans get injected into the round; we need to delete some we spawned roundstart to compensate
/datum/antagonist/slasher/spaceman/map_specific_setup()
	. = ..()
	var/list/all_fuel
	for(var/obj/item/stack/fuel/to_snipe in world)
		all_fuel += to_snipe
	if(all_fuel) // possible we went through it all already if multiple spacemen spawned
		for(var/integer=1 to round(all_fuel.len * 0.5))
			qdel(pick_n_take(all_fuel))

/*
	MUSIC
*/

/datum/action/cooldown/spaceman_manifest
	name = "Manifest"
	desc = "Root yourself in place; and pray none of your prey find you."
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "statue"
	cooldown_time = 5 SECONDS

/datum/action/cooldown/spaceman_manifest/Activate(atom/target)
	. = ..()
	for(var/datum/antagonist/slasher/spaceman/our_slasher in owner?.mind?.antag_datums)
		/// SHOG TODO - if you finish the fucking hurry up track you can do this
