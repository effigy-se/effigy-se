/datum/antagonist/slasher/dolphinman
	name = "Dolphinman"
	mob_type = /mob/living/basic/slasher/dolphinman
	fluff = "Yeah... you're man."
	ui_name = "AntagInfoDolphinman"
	jumpscare_icon_state = "dolphinman"
	jumpscare_sound = 'local/code/modules/slashco13/sound/slasher/dolphinman/kill.ogg'
	jumpscare_time = 1 SECONDS

	chase_light_range = DEFAULT_SIGHT_DISTANCE
	chase_color = LIGHT_COLOR_BRIGHT_YELLOW

	/// How much banked time to do we have?
	var/banked_time = 0

	/// How much time are we about to add if we're hiding? Used for maths as opposed to banked_time
	var/time_to_add = 0

	/// Are we currently hiding?
	var/hiding = FALSE

	var/datum/action/cooldown/dolphinman_hide/our_hide_action

/datum/antagonist/slasher/dolphinman/setup_chase_music()
	our_chase_music.volume = 75
	our_chase_music.start_sound = null
	our_chase_music.start_length = 1
	our_chase_music.mid_sounds = list(
		'local/code/modules/slashco13/sound/slasher/dolphinman/call.ogg'
	)
	our_chase_music.mid_length = 8 SECONDS
	our_chase_music.end_sound = null
	our_chase_music.extra_range = 14 // this is a "workaround" - in air quotes; to a stupid issue. tl;dr
	/// i wanted dolphinman to play a looping drone throughout the whole map like the og had; so long as you weren't close to hear the close-up drone that is this chase music
	/// that fell apart because callbacks and processing are both uniquely fucked
	/// i can't be assed


/datum/antagonist/slasher/dolphinman/give_slasher_abilities()
	. = ..()
	our_hide_action = new
	our_hide_action.Grant(owner.current)

/datum/antagonist/slasher/dolphinman/slasher_specific_chase_handling()
	if(hiding)
		return FALSE // UNHIDE FIRST YE COWARDS
	chase_length = initial(chase_length) + banked_time
	banked_time = 0
	return TRUE

/*
	HIDING
*/

/datum/action/cooldown/dolphinman_hide
	name = "Hide"
	desc = "Either hide yourself or break your hiding early."
	background_icon = 'local/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_slasher"
	button_icon = 'local/icons/mob/actions/actions_slashers.dmi'
	button_icon_state = "hide"
	overlay_icon = 'local/icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_slasher_border"
	cooldown_time = 5 SECONDS

/datum/action/cooldown/dolphinman_hide/Activate(atom/target)
	. = ..()
	if(istype(owner, /mob/living/basic/slasher/dolphinman))
		var/mob/living/basic/slasher/dolphinman/our_guy = owner
		our_guy.toggle_hide()
