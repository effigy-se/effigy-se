/// Returns the damage of the `organ_to_check`, if the organ isn't there, the proc returns `100`.
/mob/living/carbon/human/proc/check_organ_damage(obj/item/organ/organ_to_check)
	var/obj/item/organ/organ_to_track = get_organ_by_type(organ_to_check)
	if(!organ_to_track)
		return 100 //If the organ is missing, return max damage.

	return organ_to_track.damage


/// This proc saves the damage currently on `character` and reapplies it after `safe_transfer_prefs()` is applied to the `character`.
/datum/preferences/proc/safe_transfer_prefs_to_with_damage(mob/living/carbon/human/character, icon_updates = TRUE, is_antag = FALSE)
	if(!istype(character))
		return FALSE

	//Organ damage saving code.
	var/heart_damage = character.check_organ_damage(/obj/item/organ/internal/heart)
	var/liver_damage = character.check_organ_damage(/obj/item/organ/internal/liver)
	var/lung_damage = character.check_organ_damage(/obj/item/organ/internal/lungs)
	var/stomach_damage = character.check_organ_damage(/obj/item/organ/internal/stomach)
	var/brain_damage = character.check_organ_damage(/obj/item/organ/internal/brain)
	var/eye_damage = character.check_organ_damage(/obj/item/organ/internal/eyes)
	var/ear_damage = character.check_organ_damage(/obj/item/organ/internal/ears)

	var/list/trauma_list = list()
	if(character.get_traumas())
		for(var/datum/brain_trauma/trauma as anything in character.get_traumas())
			trauma_list += trauma

	var/brute_damage = character.getBruteLoss()
	var/burn_damage = character.getFireLoss()

	safe_transfer_prefs_to(character, icon_updates, is_antag)

	// Apply organ damage
	character.setOrganLoss(ORGAN_SLOT_HEART, heart_damage)
	character.setOrganLoss(ORGAN_SLOT_LIVER, liver_damage)
	character.setOrganLoss(ORGAN_SLOT_LUNGS, lung_damage)
	character.setOrganLoss(ORGAN_SLOT_STOMACH, stomach_damage)
	character.setOrganLoss(ORGAN_SLOT_EYES, eye_damage)
	character.setOrganLoss(ORGAN_SLOT_EARS, ear_damage)
	character.setOrganLoss(ORGAN_SLOT_BRAIN, brain_damage)

	//Re-Applies Trauma
	var/obj/item/organ/internal/brain/character_brain = character.get_organ_by_type(/obj/item/organ/internal/brain)

	if(length(trauma_list))
		character_brain.traumas = trauma_list

	//Re-Applies Damage
	character.setBruteLoss(brute_damage)
	character.setFireLoss(burn_damage)
