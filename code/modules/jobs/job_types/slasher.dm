/datum/job/slasher
	title = JOB_SLASHER
	description = "Protect your skulking grounds from SlashCo's grubby mits."
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "your bloodlust"
	req_admin_notify = TRUE
	exp_granted_type = EXP_TYPE_CREW
	display_order = JOB_DISPLAY_ORDER_AI
	allow_bureaucratic_error = FALSE

	department_for_prefs = /datum/job_department/assistant

	random_spawns_possible = FALSE

	job_flags = JOB_NEW_PLAYER_JOINABLE | JOB_EQUIP_RANK | JOB_BOLD_SELECT_TEXT

/datum/job/slasher/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	var/datum/antagonist/slasher/our_slasher = pick(subtypesof(/datum/antagonist/slasher))
	spawned.mind.add_antag_datum(our_slasher) // Most of the slasher code is on the antag datum rather than here.
