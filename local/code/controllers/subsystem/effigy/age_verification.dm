/mob/living/silicon/get_silicon_flavortext()
	. = ..()
	if(client?.client_verified)
		. += span_greenannounce("This player has been vetted as 18+ by staff.")

/mob/living/carbon/human/examine(mob/user)
	. = ..()
	if(client?.client_verified)
		. += span_greenannounce("This player has been vetted as 18+ by staff.")

/* Turn on after grace period
/datum/preference/toggle/master_erp_preferences/is_accessible(datum/preferences/preferences)
	. = ..()
	if(.)
		if(!preferences.parent.client_verified)
			return FALSE
	return .

/datum/preference/toggle/erp/is_accessible(datum/preferences/preferences)
	. = ..()
	if(.)
		if(!preferences.parent.client_verified)
			return FALSE
	return .
*/
