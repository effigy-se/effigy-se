/proc/minimum_opt_in_level(level = NOT_TARGET)
	var/list/all_crew = get_crewmember_minds()
	var/list/eligible_crew
	LAZYINITLIST(eligible_crew)
	for(var/datum/mind/mind as anything in all_crew)
		var/preference = mind.current?.client?.prefs?.read_preference(/datum/preference/choiced/antag_target_status)
		if(preference >= level)
			LAZYADD(eligible_crew, mind)

	return eligible_crew
