/// Common Slasher Antag Handling Here ///
/datum/antagonist/slasher
	name = "Slasher"
	roundend_category = "slashers"
	job_rank = ROLE_SLASHER
	suicide_cry = "GAME SUCK I GO BED!!"
	antagpanel_category = "Slashers"
	show_to_ghosts = TRUE
	var/mob_type = /mob/living/carbon/human
	var/slasher_outfit = /datum/outfit/job/assistant

/datum/antagonist/slasher/get_preview_icon()
	var/icon/icon = icon('local/code/modules/slashco13/icons/mob/slashers.dmi', "amogus")
	icon.Scale(ANTAGONIST_PREVIEW_ICON_SIZE, ANTAGONIST_PREVIEW_ICON_SIZE)
	return icon

/datum/antagonist/slasher/roundend_report_header()
	return "<span class='header'>Nanotrasen's Taken Note Of The Slasher's Activity:</span><br>"

/datum/antagonist/slasher/on_gain()
	. = ..()
	forge_objectives()

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

/// Exists for subtypes to override.
/datum/antagonist/slasher/proc/give_slasher_abilities()
	return

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
