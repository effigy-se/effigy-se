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
	var/icon/icon = icon('local/icons/mob/slashers.dmi', "amogus")
	icon.Scale(ANTAGONIST_PREVIEW_ICON_SIZE, ANTAGONIST_PREVIEW_ICON_SIZE)
	return icon

/datum/antagonist/slasher/roundend_report_header()
	return "<span class='header'>SlashCo's Taken Note Of The Slasher's Activity:</span><br>"

/datum/antagonist/slasher/on_gain()
	. = ..()
	equip_slasher()
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
	for(var/mob/potential_target in GLOB.player_list)
		if(potential_target.mind.assigned_role == JOB_SLASHCO_EMPLOYEE)
			var/datum/objective/assassinate/new_objective = new /datum/objective/assassinate
			new_objective.owner = owner
			new_objective.target = potential_target
			new_objective.explanation_text = "Kill [potential_target.name]."
			objectives += new_objective

/datum/antagonist/slasher/proc/process_victory()
	for(var/datum/objective/assassinate/objective in objectives)
		if(!(objective.check_completion()))
			return FALSE
	return TRUE
