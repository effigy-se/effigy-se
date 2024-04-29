/datum/controller/subsystem/job
	var/list/latejoin_interlink_trackers = list()
	var/list/latejoin_cryo_trackers = list()

/datum/controller/subsystem/job/proc/FreeRole(rank)
	if(!rank)
		return
	JobDebug("Freeing role: [rank]")
	var/datum/job/job = GetJob(rank)
	if(!job)
		return FALSE
	job.current_positions = max(0, job.current_positions - 1)

/// Used for clocking back in, re-claiming the previously freed role. Returns false if no slot is available.
/datum/controller/subsystem/job/proc/OccupyRole(rank)
	if(!rank)
		return FALSE
	JobDebug("Occupying role: [rank]")
	var/datum/job/job = GetJob(rank)
	if(!job || job.current_positions >= job.total_positions)
		return FALSE
	job.current_positions = job.current_positions + 1
	return TRUE


/datum/controller/subsystem/job/DivideOccupations(pure = FALSE, allow_all = FALSE)
	. = ..()

	var/lowpop = (length(GLOB.clients) <= CONFIG_GET(number/minimal_access_threshold))
	if(lowpop)
		log_game("Activating maintenance expanded access due to skeleton crew")
		make_maint_all_access(silent = TRUE)
