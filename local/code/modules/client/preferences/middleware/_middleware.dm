/// Called after every update_preference, returns TRUE if this handled it.
/datum/preference_middleware/proc/post_set_preference(mob/user, preference, value)
	return FALSE

/// Called when applying preferences to the mob.
/datum/preference_middleware/proc/apply_to_human(mob/living/carbon/human/target, datum/preferences/preferences, visuals_only = FALSE)
	SHOULD_NOT_SLEEP(TRUE)
	SHOULD_CALL_PARENT(FALSE)
	return
