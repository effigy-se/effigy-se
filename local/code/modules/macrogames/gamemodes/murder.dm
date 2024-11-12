/datum/macrogame_gamemode/murder
	name = "Murder"
	description = "Split between two teams; the murderer and the innocents - use your wits; your knife; or your gun - to accomplish your objectives."
	/// SHOG TEMP - RULESET GOES HERE
	blacklisted_events = list(
		/datum/round_event_control/alien_infestation, \
		/datum/round_event_control/blob, \
	)
	whitelisted_jobs = list(
		/datum/job/assistant, \
	) // SHOG TEMP - honestly I'm fine with keeping w/e jobs for Murder but I want to test if this method works
	main_menu_images = list("title-murder.png")
	anull_negative_moodles = TRUE
	required_players = 2
	roundstart_command_report_title = "Department Of Legally-Distinct Mysteries"
	roundstart_command_report_text = "Attention: a security matter requires the crew's immediate attention. A clinical trial involving pacifism - we do not have to divulge \
									further, don't test us - has backfired catastrophically. We have reason to beleive one or more of you current stationed have reacted \
									to this trial in a manner we would humbly describe as 'uncouth'. Please kindly note that we have opted to let you sort yourselves out. \
									Have a safe shift!"
	desired_emergency_dock_time = 1 MINUTES // If an earlycall's nessecary at all; just fuckin' do it fast to punish camping
	desired_emergency_escape_time = 1 MINUTES
	desired_shuttle_coefficient = 0.10
