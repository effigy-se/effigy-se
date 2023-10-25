/datum/preference/choiced/antag_target_status
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "antag_target"

/datum/preference/choiced/antag_target_status/init_possible_values()
	return list(YES_TEMP, YES_KILL, YES_ROUND_REMOVE, NOT_TARGET)

/datum/preference/choiced/antag_target_status/create_default_value()
	return YES_KILL

/datum/preference/choiced/antag_target_status/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	return passed_initial_check

/datum/preference/choiced/antag_target_status/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
