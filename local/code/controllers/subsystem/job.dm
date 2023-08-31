/datum/controller/subsystem/job/proc/FreeRole(rank)
	if(!rank)
		return
	JobDebug("Freeing role: [rank]")
	var/datum/job/job = GetJob(rank)
	if(!job)
		return FALSE
	job.current_positions = max(0, job.current_positions - 1)

/datum/controller/subsystem/job/DivideOccupations()
	. = ..()

	var/lowpop = (length(GLOB.clients) <= CONFIG_GET(number/minimal_access_threshold))
	if(lowpop)
		log_game("Activating maintenance expanded access due to skeleton crew")
		make_maint_all_access(silent = TRUE)
