/datum/controller/subsystem/events
	///list of previously run events
	var/list/previously_run = list()
	///The lower bound for how soon another random event can be scheduled.
	frequency_lower = 4 MINUTES
	///The upper bound for how soon another random event can be scheduled.
	frequency_upper = 14 MINUTES
