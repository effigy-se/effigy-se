/// Common Slasher Antag Handling Here ///
/datum/antagonist/slasher
	name = "Slasher"
	roundend_category = "slashers"
	job_rank = ROLE_SLASHER
	suicide_cry = "GAME SUCK I GO BED!!"
	antagpanel_category = "Slashers"
	show_to_ghosts = TRUE
	var/mob_type = /mob/living/carbon/human
	var/slasher_outfit = /datum/outfit/job/power_recovery

	var/fluff = "You're a piece of shitcode; Harry; get out of my sight."

	var/datum/action/cooldown/spell/get_carpspawned_idiot/carpspawn_spell
	var/datum/action/cooldown/spell/aoe/knock/slasher/knock_spell

	/// JUMPSCARE STUFF
	// How long is the mob's jumpscare animation/sfx?
	var/jumpscare_time = 3 SECONDS
	// Path to the icon file for this slasher's jumpscare
	var/jumpscare_icon = 'local/code/modules/slashco13/icons/ui/jumpscares.dmi'
	// Our icon state?
	var/jumpscare_icon_state = "amogus"
	// Sound to play while jumpscaring; if any
	var/jumpscare_sound = 'local/code/modules/slashco13/sound/slasher/imposter/stealthkill.ogg'
	// How loud is our jumpscare?
	var/jumpscare_volume = 75
	// How long does it take to wind up again?
	var/jumpscare_cooldown_length = 10 SECONDS
	/// CHASE STUFF
	// How fast do we move while chasing? Modifier
	var/chase_movespeed_mod = -1.1
	// How long is our chase period?
	var/chase_length = 15 SECONDS
	var/datum/action/cooldown/spell/slasher_chase/our_chase_attack
	// Do we start with the chase action button? Used mostly by the Imposter
	var/start_with_chase = TRUE
	var/datum/looping_sound/slasher_chase/our_chase_music = /datum/looping_sound/slasher_chase
	// How long does it take to recharge from a chase?
	var/chase_cooldown_length = 18 SECONDS

	// Chase light range?
	var/chase_light_range = 3.5
	// Chase color?
	var/chase_color = LIGHT_COLOR_INTENSE_RED

	// Are we currently in chase mode?
	var/is_chasing = FALSE

	COOLDOWN_DECLARE(jumpscare_cooldown)

/datum/antagonist/slasher/on_gain()
	. = ..()
	forge_objectives()
	equip_slasher()
	map_specific_setup()

/datum/antagonist/slasher/ui_static_data(mob/user)
	var/list/data = list()
	data["fluff"] = fluff
	data["objectives"] = get_objectives()
	data["explain_attack"] = TRUE
	return data

/datum/antagonist/slasher/proc/equip_slasher()
	if(mob_type != /mob/living/carbon/human)
		var/mob/SlasherToBe = owner.current
		SlasherToBe.change_mob_type(mob_type, null, src.name, TRUE)
	else
		var/mob/living/carbon/human/our_carbon = owner.current
		our_carbon.equipOutfit(slasher_outfit)
	give_slasher_abilities()

// Exists for subtypes to override.
/datum/antagonist/slasher/proc/map_specific_setup()
	return

/datum/antagonist/slasher/get_preview_icon()
	var/icon/icon = icon('local/code/modules/slashco13/icons/mob/slashers.dmi', "amogus")

	var/icon/princess = icon('local/code/modules/slashco13/icons/mob/slashers.dmi', "princess")
	princess.Blend(rgb(128, 128, 128, 128), ICON_MULTIPLY)
	icon.Blend(princess, ICON_UNDERLAY, -world.icon_size / 4, 0)

	var/icon/sid = icon('local/code/modules/slashco13/icons/mob/slashers.dmi', "sid")
	sid.Blend(rgb(128, 128, 128, 128), ICON_MULTIPLY)
	icon.Blend(sid, ICON_UNDERLAY, world.icon_size / 4, 0)

	icon.Scale(ANTAGONIST_PREVIEW_ICON_SIZE, ANTAGONIST_PREVIEW_ICON_SIZE)
	return icon

/datum/antagonist/slasher/roundend_report_header()
	return "<span class='header'>Nanotrasen's Taken Note Of The Slasher's Activity:</span><br>"

/// Exists for subtypes to add onto.
/datum/antagonist/slasher/proc/give_slasher_abilities()
	our_chase_attack = new
	if(start_with_chase)
		our_chase_attack.Grant(owner.current)
	carpspawn_spell = new
	carpspawn_spell.Grant(owner.current)
	knock_spell = new
	knock_spell.Grant(owner.current)
	our_chase_music = new
	setup_chase_music()

/// Exists for subtypes to override.
/datum/antagonist/slasher/proc/setup_chase_music()
	return

/datum/antagonist/slasher/forge_objectives()
	. = ..()
	update_objectives()
	var/datum/action/antag_info/info_button = info_button_ref?.resolve()
	if(info_button)
		info_button.target.ui_close(owner)
		info_button.Trigger()

/// Long-term this would probably be best moved to team logic. Oh well
/datum/antagonist/slasher/proc/update_objectives()
	var/untracked_techs = list()
	for(var/datum/mind/potential_target in SSticker.minds)
		if(potential_target.antag_datums == null) // Note the antag check also prevents you from targetting yourself
			untracked_techs += potential_target

	for(var/datum/objective/assassinate/kill_objective in objectives)
		untracked_techs -= kill_objective.target

	for(var/datum/mind/extra_kill_target in untracked_techs)
		var/datum/objective/assassinate/new_target = new()
		new_target.target = extra_kill_target
		new_target.update_explanation_text()
		objectives += new_target

	addtimer(CALLBACK(src, PROC_REF(update_objectives)),HEAD_UPDATE_PERIOD,TIMER_UNIQUE)

/*
	ANTI-GBJ SPELL
*/

/datum/action/cooldown/spell/get_carpspawned_idiot // Map around this; please.
	name = "Shift"
	desc = "Shifts you to just outside the station; ready to hunt anew..."
	sound = 'sound/magic/Repulse.ogg'
	background_icon = 'local/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_slasher"
	button_icon = 'local/icons/mob/actions/actions_slashers.dmi'
	button_icon_state = "carpspawn"
	overlay_icon = 'local/icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_slasher_border"
	spell_requirements = NONE
	cooldown_time = 2 MINUTES

/datum/action/cooldown/spell/get_carpspawned_idiot/can_cast_spell(feedback)
	return TRUE

/datum/action/cooldown/spell/get_carpspawned_idiot/cast(mob/living/cast_on)
	. = ..()
	if(!istype(cast_on))
		return
	var/datum/effect_system/spark_spread/quantum/sparks = new
	sparks.set_up(10, 1, cast_on)
	sparks.attach(cast_on.loc)
	sparks.start()
	var/potential_spawn = find_space_spawn()
	if(!potential_spawn)
		potential_spawn = get_safe_random_station_turf() /// No carpspawns? Fuggit; random safe tile
	cast_on.forceMove(potential_spawn)

/*
	JUMPSCARE SPELL
*/

/// JUMPSCARE ZONE ///

/datum/antagonist/slasher/proc/jumpscare(mob/living/target, mob/living/user)
	if(!istype(target))
		return
	target.Paralyze(jumpscare_time, TRUE)
	target.anchored = TRUE // prevents breaking the illusion
	user.Paralyze(jumpscare_time, TRUE)
	if(target.client && target.hud_used && (jumpscare_icon != null) && target != user)
		target.hud_used.show_hud(HUD_STYLE_NOHUD)
		var/image/jumpscare = image(icon = jumpscare_icon, loc = get_turf(target), icon_state = jumpscare_icon_state, dir = SOUTH, pixel_x = -288, pixel_y = -224)
		SET_PLANE(jumpscare, ABOVE_HUD_PLANE, target)
		target.client.images += jumpscare
		playsound(get_turf(target), jumpscare_sound, jumpscare_volume, FALSE)
		slasher_specific_jumpscare_effects(jumpscare, target, user) // Used for animations; mostly
		addtimer(CALLBACK(src, PROC_REF(delete_jumpscare), target, jumpscare), jumpscare_time, TIMER_DELETE_ME | TIMER_CLIENT_TIME)
		addtimer(CALLBACK(src, PROC_REF(prank_em_john), target, jumpscare), jumpscare_time, TIMER_DELETE_ME | TIMER_CLIENT_TIME)
	else // Play pretend with it
		playsound(get_turf(target), jumpscare_sound, jumpscare_volume, FALSE)
		addtimer(CALLBACK(src, PROC_REF(prank_em_john), target), jumpscare_time, TIMER_DELETE_ME | TIMER_CLIENT_TIME)

/// Exists for subtypes to override.
/datum/antagonist/slasher/proc/slasher_specific_jumpscare_effects(image/jumpscare, mob/living/target, mob/living/user)
	return

/datum/antagonist/slasher/proc/delete_jumpscare(mob/living/target, image/jumpscare)
	target?.client?.images -= jumpscare
	qdel(jumpscare)
	if(target.hud_used && target.client)
		target.hud_used.show_hud(HUD_STYLE_STANDARD)

/datum/antagonist/slasher/proc/prank_em_john(mob/living/target)
	if(!istype(target))
		return
	target.anchored = FALSE // okay; if there was a jumpscare, it's over; you can be dragged now
	target.adjustBruteLoss(300)
	ADD_TRAIT(target, TRAIT_DEFIB_BLACKLISTED, REF(src))

/// This isn't universal but is close enough to be here; it's only meant to be given to mobs that aren't using the generic /mob/living/basic/slasher as a base. Humans and the like.
/datum/action/cooldown/mob_cooldown/jumpscare
	name = "Kill"
	desc = "Attack and kill your target; if you're in proximity."
	background_icon = 'local/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_slasher"
	button_icon = 'local/icons/mob/actions/actions_slashers.dmi'
	button_icon_state = "kill"
	overlay_icon = 'local/icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_slasher_border"
	click_to_activate = TRUE
	shared_cooldown = NONE
	cooldown_time = /datum/antagonist/slasher::jumpscare_cooldown_length

/datum/action/cooldown/mob_cooldown/jumpscare/Grant(mob/grant_to)
	. = ..()
	if(!owner)
		return
	for(var/datum/antagonist/slasher/our_slasher in owner?.mind?.antag_datums)
		cooldown_time = our_slasher.jumpscare_cooldown_length

/datum/action/cooldown/mob_cooldown/jumpscare/set_click_ability(mob/on_who)
	. = ..()
	if(!.)
		return

	on_who.balloon_alert(on_who, "prepared to kill")

/datum/action/cooldown/mob_cooldown/jumpscare/unset_click_ability(mob/on_who, refund_cooldown = TRUE)
	. = ..()
	if(!.)
		return

	if(refund_cooldown)
		on_who.balloon_alert(on_who, "kill cancelled")

/datum/action/cooldown/mob_cooldown/jumpscare/Activate(atom/target)
	if(!owner.Adjacent(target))
		owner.balloon_alert(owner, "must be closer!")
		return FALSE
	for(var/datum/antagonist/slasher/our_slasher in owner?.mind?.antag_datums)
		our_slasher.jumpscare(target, owner)
		return TRUE

/*
	CHASE SPELL
*/

/// CHASE STUFF
/datum/looping_sound/slasher_chase
	start_sound = 'local/code/modules/slashco13/sound/slasher/imposter/chase.ogg'
	start_length = 5
	mid_sounds = list('local/code/modules/slashco13/sound/slasher/imposter/chase.ogg' = 1)
	mid_length = 5
	end_sound = 'local/code/modules/slashco13/sound/slasher/imposter/chase.ogg'
	each_once = TRUE
	in_order = TRUE

/datum/movespeed_modifier/slasher_chase
	variable = TRUE
	flags = IGNORE_NOSLOW

/datum/action/cooldown/spell/slasher_chase
	name = "Chase"
	desc = "Begin a chase with your prey."
	background_icon = 'local/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_slasher"
	button_icon = 'local/icons/mob/actions/actions_slashers.dmi'
	button_icon_state = "chase"
	overlay_icon = 'local/icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_slasher_border"
	spell_requirements = NONE
	cooldown_time = 3 MINUTES

/datum/action/cooldown/spell/slasher_chase/Grant(mob/grant_to)
	. = ..()
	if(!owner)
		return
	for(var/datum/antagonist/slasher/our_slasher in owner?.mind?.antag_datums)
		cooldown_time = our_slasher.chase_cooldown_length

/datum/action/cooldown/spell/slasher_chase/can_cast_spell(feedback)
	return TRUE

/// this should probably be made toggleable rather than just a block of time you can chase but i can't be assed rn
/// ^ this has since become load-bearing for a few slashers lol
/datum/action/cooldown/spell/slasher_chase/cast(mob/living/cast_on)
	for(var/datum/antagonist/slasher/our_slasher in owner?.mind?.antag_datums)
		if(!our_slasher.slasher_specific_chase_handling())
			return
	. = ..()
	if(!istype(cast_on))
		return
	for(var/datum/antagonist/slasher/our_slasher in owner?.mind?.antag_datums)
		cast_on.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/slasher_chase, multiplicative_slowdown = our_slasher.chase_movespeed_mod)
		addtimer(CALLBACK(src, PROC_REF(end_chase), cast_on), our_slasher.chase_length)
		our_slasher.our_chase_music.start(cast_on)
		our_slasher.is_chasing = TRUE
		cast_on.set_light(l_range = our_slasher.chase_light_range, l_color = our_slasher.chase_color)

/datum/action/cooldown/spell/slasher_chase/proc/end_chase(mob/living/cast_on)
	cast_on.set_light(l_range = initial(cast_on.light_range), l_color = initial(cast_on.light_color))
	for(var/datum/antagonist/slasher/our_slasher in owner?.mind?.antag_datums)
		our_slasher.our_chase_music.stop(TRUE) // parent mob can change; easier to just whiste innocently about it
		our_slasher.is_chasing = FALSE
	cast_on.remove_movespeed_modifier(/datum/movespeed_modifier/slasher_chase)

/// Exists for other slashers to override since I TURBO fucked up
/datum/antagonist/slasher/proc/slasher_specific_chase_handling()
	return TRUE

/*
	KNOCK SPELL
*/
// gtfo the dorm idiot

/datum/action/cooldown/spell/aoe/knock/slasher
	name = "Slasher's Knock"
	sound = null
	background_icon = 'local/icons/mob/actions/backgrounds.dmi'
	background_icon_state = "bg_slasher"
	button_icon = 'local/icons/mob/actions/actions_slashers.dmi'
	button_icon_state = "knock"
	overlay_icon = 'local/icons/mob/actions/backgrounds.dmi'
	overlay_icon_state = "bg_slasher_border"
	cooldown_time = 1 SECONDS
	invocation = null
	invocation_type = INVOCATION_NONE
	spell_requirements = NONE
