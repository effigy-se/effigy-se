/datum/preference/choiced/latejoin_location
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "latejoin_location"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/latejoin_location/init_possible_values()
	return list(JOB_LATEJOINPREF_ARRIVALS, JOB_LATEJOINPREF_CRYO, JOB_LATEJOINPREF_INTERLINK)

/datum/preference/choiced/latejoin_location/create_default_value()
	return JOB_LATEJOINPREF_ARRIVALS

/datum/preference/choiced/latejoin_location/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return
