/datum/job/broadcast_team
	title = JOB_BROADCAST_TEAM
	description = "Brainstorm TV shows with your coworkers. End up broadcasting the world's most intense game of Strip Kotahi."
	department_head = list(JOB_HEAD_OF_PERSONNEL)
	faction = FACTION_STATION
	total_positions = 6 // Essentially: Actors, Cameramen, and Sethands. This leaves the door open for them to get creative with larger productions.
	spawn_positions = 5
	supervisors = SUPERVISOR_HOP
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "BROADCAST_TEAM"

	outfit = /datum/outfit/job/broadcast_team
	plasmaman_outfit = /datum/outfit/plasmaman

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_ENG

	display_order = JOB_DISPLAY_ORDER_BROADCAST_TEAM
	bounty_types = CIV_JOB_BASIC
	departments_list = list(
		/datum/job_department/service,
		)

	family_heirlooms = list(/obj/item/lighter, /obj/item/lighter/greyscale, /obj/item/storage/box/matches)

	mail_goodies = list(
		/obj/item/lighter = 30,
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN
	rpg_title = "Scribe"

/datum/job/broadcast_team/config_check()
	return CONFIG_GET(flag/allow_station_jobs)

/datum/outfit/job/broadcast_team
	name = "Broadcast Team"
	jobtype = /datum/job/broadcast_team

	id_trim = /datum/id_trim/job/broadcast_team
	belt = /obj/item/modular_computer/pda/broadcast
	uniform = /obj/item/clothing/under/suit/black_really
	ears = /obj/item/radio/headset/headset_bro
