/datum/id_trim/job/power_recovery
	assignment = "Power Recovery Technician"
	trim_state = "trim_deathcommando"
	department_color = COLOR_PRISONER_BLACK
	subdepartment_color = COLOR_PRISONER_BLACK
	sechud_icon_state = SECHUD_DEATH_COMMANDO
	job = /datum/job/power_recovery

/datum/id_trim/job/power_recovery/New() // Basically required for the gamemode
	extra_access |= (SSid_access.get_flag_access_list(ACCESS_FLAG_COMMON) + SSid_access.get_flag_access_list(ACCESS_FLAG_COMMAND))
	extra_wildcard_access |= (SSid_access.get_flag_access_list(ACCESS_FLAG_PRV_COMMAND) + SSid_access.get_flag_access_list(ACCESS_FLAG_CAPTAIN))
	minimal_access |= (SSid_access.get_flag_access_list(ACCESS_FLAG_COMMON) + SSid_access.get_flag_access_list(ACCESS_FLAG_COMMAND))
	minimal_wildcard_access |= (SSid_access.get_flag_access_list(ACCESS_FLAG_PRV_COMMAND) + SSid_access.get_flag_access_list(ACCESS_FLAG_CAPTAIN))
	return ..()
