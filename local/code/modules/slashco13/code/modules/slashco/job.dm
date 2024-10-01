/datum/job/power_recovery
	title = JOB_POWER_RECOVERY
	description = "Scour Ruins, Fuel Generators, and survive the machinations of whatever Slasher's present in your active zone."
	faction = FACTION_SLASHCO
	total_positions = 4
	spawn_positions = 4
	supervisors = "your corporate overlords"
	exp_granted_type = EXP_TYPE_CREW
	outfit = /datum/outfit/job/power_recovery
	plasmaman_outfit = /datum/outfit/plasmaman
	paycheck_department = ACCOUNT_CIV
	display_order = JOB_DISPLAY_ORDER_ASSISTANT

	department_for_prefs = /datum/job_department/assistant

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
	uniform = /obj/item/clothing/under/color/black
	ears = null
	shoes = /obj/item/clothing/shoes/workboots
	l_pocket = /obj/item/flashlight

/*
	SLASHER
*/
/datum/job/slasher
	title = JOB_SLASHER

/datum/job/slasher/after_roundstart_spawn(mob/living/spawning, client/player_client)
	. = ..()
	var/datum/antagonist/slasher/slasher_antag = spawning.mind.has_antag_datum(/datum/antagonist/slasher)
	if(!slasher_antag)
		CRASH("player occupying slasher job without antag datum")
	slasher_antag.equip_slasher()
