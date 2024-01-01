/datum/wound/slash/flesh/try_handling(mob/living/carbon/human/user)
	if(!isfeline(user))
		return FALSE
	return ..()
