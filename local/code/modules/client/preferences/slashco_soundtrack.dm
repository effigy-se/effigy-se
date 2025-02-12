/datum/preference/choiced/slashco_soundtrack
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "slashco_soundtrack"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/choiced/slashco_soundtrack/init_possible_values()
	return list(SLASHCO_SOUNDTRACK_REMIX, SLASHCO_SOUNDTRACK_CLASSIC)

/datum/preference/choiced/slashco_soundtrack/create_default_value()
	return SLASHCO_SOUNDTRACK_CLASSIC
