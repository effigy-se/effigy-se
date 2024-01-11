GLOBAL_VAR_INIT(bloopers_allowed, TRUE) // For administrators

/datum/smite/normalblooper
	name = "Normal blooper"

/datum/smite/normalblooper/effect(client/user, mob/living/carbon/human/target)
	. = ..()
	target.blooper = null
	target.blooper_id = pick(GLOB.blooper_random_list)
	target.blooper_speed = round((BLOOPER_DEFAULT_MINSPEED + BLOOPER_DEFAULT_MAXSPEED) / 2)
	target.blooper_pitch = round((BLOOPER_DEFAULT_MINPITCH + BLOOPER_DEFAULT_MAXPITCH) / 2)
	target.blooper_pitch_range = 0.2


/datum/admins/proc/toggle_bloopers()
	set category = "Server"
	set desc = "Toggle ANNOYING NOIZES"
	set name = "Toggle Bloopers"
	toggle_bloopers()
	log_admin("[key_name(usr)] toggled Blooper.")
	message_admins("[key_name_admin(usr)] toggled Blooper.")
	SSblackbox.record_feedback("nested tally", "admin_toggle", 1, list("Toggle Blooper", "[GLOB.bloopers_allowed ? "Enabled" : "Disabled"]")) // If you are copy-pasting this, ensure the 4th parameter is unique to the new proc!

/world/AVerbsAdmin() // WHAT IS THIS
	. = ..()
	return . + /datum/admins/proc/toggle_bloopers

/proc/toggle_bloopers(toggle = null)
	if(toggle != null)
		if(toggle != GLOB.bloopers_allowed)
			GLOB.bloopers_allowed = toggle
		else
			return
	else
		GLOB.bloopers_allowed = !GLOB.bloopers_allowed
	to_chat(world, "<span class='oocplain'><B>Bloopers have been globally [GLOB.bloopers_allowed ? "enabled" : "disabled"].</B></span>")

/datum/preference/choiced/blooper
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "blooper_speech"

/datum/preference/choiced/blooper/init_possible_values()
	return assoc_to_keys(GLOB.blooper_list)

/datum/preference/choiced/blooper/apply_to_human(mob/living/carbon/human/target, value, /datum/preference/numeric/blooper_speech_speed)
	target.set_blooper(value)

/datum/preference_middleware/blooper
	/// Cooldown on requesting a Blooper preview.
	COOLDOWN_DECLARE(blooper_cooldown)

	action_delegations = list(
		"play_blooper" = PROC_REF(play_blooper),
	)

/datum/preference_middleware/blooper/proc/play_blooper(list/params, mob/user)
	if(!COOLDOWN_FINISHED(src, blooper_cooldown))
		return TRUE
	var/atom/movable/blooperbox = new(get_turf(user))
	blooperbox.set_blooper(preferences.read_preference(/datum/preference/choiced/blooper))
	blooperbox.blooper_pitch = preferences.read_preference(/datum/preference/numeric/blooper_speech_pitch)
	blooperbox.blooper_speed = preferences.read_preference(/datum/preference/numeric/blooper_speech_speed)
	blooperbox.blooper_pitch_range = preferences.read_preference(/datum/preference/numeric/blooper_pitch_range)
	var/total_delay
	for(var/i in 1 to (round((32 / blooperbox.blooper_speed)) + 1))
		addtimer(CALLBACK(blooperbox, TYPE_PROC_REF(/atom/movable, blooper), list(user), 7, 70, BLOOPER_DO_VARY(blooperbox.blooper_pitch, blooperbox.blooper_pitch_range)), total_delay)
		total_delay += rand(DS2TICKS(blooperbox.blooper_speed/4), DS2TICKS(blooperbox.blooper_speed/4) + DS2TICKS(blooperbox.blooper_speed/4)) TICKS
	QDEL_IN(blooperbox, total_delay)
	COOLDOWN_START(src, blooper_cooldown, 2 SECONDS)
	return TRUE

/datum/preference/numeric/blooper_speech_speed
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "blooper_speech_speed"
	minimum = BLOOPER_DEFAULT_MINSPEED
	maximum = BLOOPER_DEFAULT_MAXSPEED
	step = 0.01

/datum/preference/numeric/blooper_speech_speed/apply_to_human(mob/living/carbon/human/target, value)
	target.blooper_speed = value

/datum/preference/numeric/blooper_speech_speed/create_default_value()
	return round((BLOOPER_DEFAULT_MINSPEED + BLOOPER_DEFAULT_MAXSPEED) / 2)

/datum/preference/numeric/blooper_speech_pitch
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "blooper_speech_pitch"
	minimum = BLOOPER_DEFAULT_MINPITCH
	maximum = BLOOPER_DEFAULT_MAXPITCH
	step = 0.01

/datum/preference/numeric/blooper_speech_pitch/apply_to_human(mob/living/carbon/human/target, value)
	target.blooper_pitch = value

/datum/preference/numeric/blooper_speech_pitch/create_default_value()
	return round((BLOOPER_DEFAULT_MINPITCH + BLOOPER_DEFAULT_MAXPITCH) / 2)

/datum/preference/numeric/blooper_pitch_range
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "blooper_pitch_range"
	minimum = BLOOPER_DEFAULT_MINVARY
	maximum = BLOOPER_DEFAULT_MAXVARY
	step = 0.01

/datum/preference/numeric/blooper_pitch_range/apply_to_human(mob/living/carbon/human/target, value)
	target.blooper_pitch_range = value

/datum/preference/numeric/blooper_pitch_range/create_default_value()
	return 0.2

/// Can I use the blooper?
/datum/preference/toggle/send_sound_blooper
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "send_sound_blooper"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/// Can I hear everyone else's bloops?
/datum/preference/toggle/hear_sound_blooper
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "hear_sound_blooper"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/// It's was stoolen from Splurt build >:3 and from fluffySTG!! nyeehehehheee!~
/datum/blooper
	var/name = "None"
	var/id = "Default"
	var/soundpath

	var/minpitch = BLOOPER_DEFAULT_MINPITCH
	var/maxpitch = BLOOPER_DEFAULT_MAXPITCH
	var/minvariance = BLOOPER_DEFAULT_MINVARY
	var/maxvariance = BLOOPER_DEFAULT_MAXVARY

	// Speed vars. Speed determines the number of characters required for each blooper, with lower speeds being faster with higher blooper density
	var/minspeed = BLOOPER_DEFAULT_MINSPEED
	var/maxspeed = BLOOPER_DEFAULT_MAXSPEED

	// Visibility vars. Regardless of what's set below, these can still be obtained via adminbus and genetics. Rule of fun.
	var/list/ckeys_allowed
	var/ignore = FALSE // If TRUE - only for admins
	var/allow_random = FALSE
