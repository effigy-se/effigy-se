/datum/job/power_recovery
	title = JOB_POWER_RECOVERY
	description = "Scour Ruins, Fuel Generators, and survive the machinations of whatever Slasher's present in your active zone."
	faction = FACTION_STATION
	total_positions = 4
	spawn_positions = 4
	supervisors = "your corporate overlords"
	exp_granted_type = EXP_TYPE_CREW
	outfit = /datum/outfit/job/power_recovery
	plasmaman_outfit = /datum/outfit/plasmaman
	paycheck_department = ACCOUNT_CIV
	display_order = JOB_DISPLAY_ORDER_ASSISTANT

	config_tag = "POWER_RECOVERY_TECHNICIAN"

	department_for_prefs = /datum/job_department/assistant

	departments_list = list(
		/datum/job_department/silicon,
		/datum/job_department/service,
		/datum/job_department/cargo,
		/datum/job_department/science,
		/datum/job_department/medical,
		/datum/job_department/engineering,
		/datum/job_department/security,
		/datum/job_department/command
		) // Every department in order to make CI happy

	family_heirlooms = list(/obj/item/bonesetter)

	mail_goodies = list(
		/obj/effect/spawner/random/food_or_drink/donkpockets = 10,
		/obj/item/crowbar/large = 1
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

/datum/outfit/job/power_recovery
	name = JOB_POWER_RECOVERY
	jobtype = /datum/job/power_recovery
	id = /obj/item/card/id/advanced/black
	id_trim = /datum/id_trim/job/power_recovery
	uniform = /obj/item/clothing/under/color/darkblue
	ears = null
	belt = /obj/item/storage/belt/utility/full/engi
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/flashlight
	r_pocket = /obj/item/toy/crayon/spraycan

/*
	SLASHER
*/
/datum/job/slasher
	title = JOB_SLASHER
