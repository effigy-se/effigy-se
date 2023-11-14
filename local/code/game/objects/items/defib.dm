/**
 * Global timer proc used in defib.dm. Removes the temporary trauma caused by being defibbed as a synth.
 *
 * Args:
 * * obj/item/organ/internal/brain/synth_brain: The brain with the trauma on it. Non-nullable.
 * * datum/brain_trauma/trauma: The trauma itself. Non-nullable.
 */
/proc/remove_synth_defib_trauma(obj/item/organ/internal/brain/synth_brain, datum/brain_trauma/trauma)
	if (QDELETED(synth_brain) || QDELETED(trauma))
		return

	QDEL_NULL(trauma)

/obj/item/shockpaddles/do_help(mob/living/carbon/H, mob/living/user)
	var/target_synthetic = (user.mob_biotypes & MOB_ROBOTIC)
	if (target_synthetic)
		to_chat(user, span_boldwarning("[H] is a synthetic lifeform! This defibrillator probably isn't calibrated to revive [H.p_them()] properly and could have some serious consequences! \
		[span_warning("You might want to [span_blue("surgically revive [H.p_them()]")]...")]"))
		balloon_alert(user, "target is synthetic!") // immediately grabs their attention even if they dont see chat
	. = ..()
