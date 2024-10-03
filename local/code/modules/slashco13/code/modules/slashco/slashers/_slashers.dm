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

	var/datum/action/cooldown/spell/get_carpspawned_idiot/carpspawn_spell

	/// JUMPSCARE STUFF
	// How long is the mob's jumpscare animation/sfx?
	var/jumpscare_time = 3 SECONDS
	var/jumpscare_icon = 'local/code/modules/slashco13/icons/ui/jumpscares.dmi'
	var/jumpscare_icon_state = "amogus"
	var/jumpscare_sound = 'local/code/modules/slashco13/sound/slasher/imposter/stealthkill.ogg'
	var/jumpscare_cooldown_length = 10 SECONDS
	/// CHASE STUFF
	// How fast do we move while chasing? Modifier
	var/chase_movespeed_mod = -1
	// How long is our chase period?
	var/chase_length = 30 SECONDS
	var/datum/action/cooldown/spell/slasher_chase/our_chase_attack
	// Do we start with the chase action button? Used mostly by the Imposter
	var/start_with_chase = TRUE
	var/datum/looping_sound/slasher_chase/our_chase_music = /datum/looping_sound/slasher_chase
	// How long does it take to recharge from a chase?
	var/chase_cooldown_length = 3 MINUTES

	COOLDOWN_DECLARE(jumpscare_cooldown)

/datum/antagonist/slasher/on_gain()
	. = ..()
	forge_objectives()
	equip_slasher()

/datum/antagonist/slasher/proc/equip_slasher(mob/our_slasher = null)
	if(isnull(our_slasher))
		our_slasher = owner.current
	if(mob_type != /mob/living/carbon/human)
		var/mob/SlasherToBe = our_slasher
		SlasherToBe.change_mob_type(mob_type, null, src.name, TRUE)
	else
		var/mob/living/carbon/human/our_carbon = our_slasher
		our_carbon.equipOutfit(slasher_outfit)
	give_slasher_abilities(our_slasher)

/datum/antagonist/slasher/get_preview_icon()
	var/icon/icon = icon('local/code/modules/slashco13/icons/mob/slashers.dmi', "amogus")
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

/datum/antagonist/slasher/forge_objectives()
	. = ..()
	update_objectives()

/// Long-term this would probably be best moved to team logic. Oh well
/datum/antagonist/slasher/proc/update_objectives()
	var/untracked_techs = list()
	for(var/datum/mind/potential_target as anything in get_crewmember_minds())
		if(potential_target.assigned_role == JOB_POWER_RECOVERY)
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
	button_icon_state = "lightning"
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

/datum/antagonist/slasher/proc/jumpscare(mob/living/target)
	if(!istype(target))
		return
	if(target.client && target.hud_used)
		target.hud_used.show_hud(HUD_STYLE_NOHUD)
		target.Paralyze(jumpscare_time)
		owner.current.Paralyze(jumpscare_time)
		var/image/jumpscare = image(icon = jumpscare_icon, loc = target, icon_state = jumpscare_icon_state, dir = SOUTH, pixel_x = -288, pixel_y = -224)
		SET_PLANE(jumpscare, ABOVE_HUD_PLANE, target)
		target.client.images += jumpscare
		playsound(get_turf(target), jumpscare_sound, 75, FALSE)
		addtimer(CALLBACK(src, PROC_REF(delete_jumpscare), target, jumpscare), jumpscare_time, TIMER_DELETE_ME | TIMER_CLIENT_TIME)
		addtimer(CALLBACK(src, PROC_REF(prank_em_john), target, jumpscare), jumpscare_time, TIMER_DELETE_ME | TIMER_CLIENT_TIME)
	else // Play pretend with it
		playsound(get_turf(target), jumpscare_sound, 75, FALSE)
		addtimer(CALLBACK(src, PROC_REF(prank_em_john), target), jumpscare_time, TIMER_DELETE_ME | TIMER_CLIENT_TIME)

/datum/antagonist/slasher/proc/delete_jumpscare(mob/living/target, image/jumpscare)
	target?.client?.images -= jumpscare
	qdel(jumpscare)
	if(target.hud_used && target.client)
		target.hud_used.show_hud(HUD_STYLE_STANDARD)

/datum/antagonist/slasher/proc/prank_em_john(mob/living/target)
	if(!istype(target))
		return
	target.adjustBruteLoss(300)
	ADD_TRAIT(target, TRAIT_DEFIB_BLACKLISTED, REF(src))

/// This isn't universal but is close enough to be here; it's only meant to be given to mobs that aren't using the generic /mob/living/basic/slasher as a base. Humans and the like.

/datum/action/cooldown/mob_cooldown/jumpscare
	name = "Kill"
	desc = "Attack and kill your target; if you're in proximity."
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
		our_slasher.jumpscare(target)
		return TRUE

/*
	CHASE SPELL
*/

/// CHASE STUFF
/datum/looping_sound/slasher_chase
	start_sound = 'local/code/modules/slashco13/sound/slasher/imposter/chase.ogg'
	start_length = 4
	mid_sounds = list('local/code/modules/slashco13/sound/slasher/imposter/chase.ogg' = 1)
	mid_length = 4
	end_sound = 'local/code/modules/slashco13/sound/slasher/imposter/chase.ogg'

/datum/movespeed_modifier/slasher_chase
	variable = TRUE
	flags = IGNORE_NOSLOW

/datum/action/cooldown/spell/slasher_chase
	name = "Chase"
	desc = "Begin a chase with your prey."
	button_icon_state = "blink"
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
/datum/action/cooldown/spell/slasher_chase/cast(mob/living/cast_on)
	. = ..()
	if(!istype(cast_on))
		return
	for(var/datum/antagonist/slasher/our_slasher in owner?.mind?.antag_datums)
		cast_on.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/slasher_chase, multiplicative_slowdown = our_slasher.chase_movespeed_mod)
		addtimer(CALLBACK(src, PROC_REF(end_chase), cast_on), our_slasher.chase_length)
		if(!our_slasher.our_chase_music)
			var/datum/looping_sound/slasher_chase/chasemus_to_be = our_slasher.our_chase_music
			new chasemus_to_be
			chasemus_to_be.start(cast_on)
	cast_on.set_light(l_range = 3.5, l_color = LIGHT_COLOR_INTENSE_RED)

/datum/action/cooldown/spell/slasher_chase/proc/end_chase(mob/living/cast_on)
	cast_on.set_light(l_range = initial(cast_on.light_range), l_color = initial(cast_on.light_color))
	for(var/datum/antagonist/slasher/our_slasher in owner?.mind?.antag_datums)
		QDEL_NULL(our_slasher.our_chase_music)
	cast_on.remove_movespeed_modifier(/datum/movespeed_modifier/slasher_chase)
