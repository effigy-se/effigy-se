/datum/macrogame_gamemode/murder
	name = "Murder"
	description = "Split between two teams; the murderer and the innocents - use your wits; your knife; or your gun - to accomplish your objectives."
	blacklisted_events = list(
		/datum/round_event_control/alien_infestation, \
		/datum/round_event_control/blob, \
	)
	whitelisted_jobs = list(
		/datum/job/assistant, \
	)
