/datum/id_trim/job/broadcast_team
	assignment = "Broadcast Team"
	trim_icon = 'packages/broadcast_team/icons/obj/card.dmi'
	trim_state = "trim_broadcast_team"
	department_color = COLOR_SERVICE_LIME
	subdepartment_color = COLOR_SERVICE_LIME
	sechud_icon_state = SECHUD_BROADCAST_TEAM
	minimal_access = list(
		ACCESS_BROADCAST_CENTRE,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_SERVICE,
		ACCESS_THEATRE,
		)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
		ACCESS_HOP,
		)
	job = /datum/job/broadcast_team
