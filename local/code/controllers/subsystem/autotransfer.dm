#define NO_VOTE_CAP -1

SUBSYSTEM_DEF(autotransfer)
	name = "Autotransfer"
	flags = SS_KEEP_TIMING | SS_BACKGROUND
	runlevels = RUNLEVEL_GAME
	wait = 1 MINUTES

	var/start_time
	var/target_time
	var/initial_vote
	var/vote_interval
	var/max_votes
	var/current_votes = 0

/datum/controller/subsystem/autotransfer/Initialize()
	if(!CONFIG_GET(flag/autotransfer)) //Autotransfer voting disabled.
		can_fire = FALSE
		return SS_INIT_NO_NEED

	initial_vote = CONFIG_GET(number/vote_autotransfer_initial)
	vote_interval = CONFIG_GET(number/vote_autotransfer_interval)
	max_votes = CONFIG_GET(number/vote_autotransfer_maximum)
	return SS_INIT_SUCCESS

/datum/controller/subsystem/autotransfer/Recover()
	start_time = SSautotransfer.start_time
	vote_interval = SSautotransfer.vote_interval
	current_votes = SSautotransfer.current_votes

/datum/controller/subsystem/autotransfer/fire()
	if(REALTIMEOFDAY < target_time)
		return
	if(world.time - SSticker.round_start_time < vote_interval)
		return
	if(max_votes == NO_VOTE_CAP || max_votes > current_votes)
		log_game("Autotransfer: Vote initiated. RT:[REALTIMEOFDAY] RSRT:[SSticker.round_start_real_time] ST:[start_time] TT:[target_time] VI:[vote_interval] CV:[current_votes] MV:[max_votes] WT:[world.time] RST:[SSticker.round_start_time]")
		SSvote.initiate_vote(/datum/vote/transfer_vote, "automatic transfer", forced = TRUE)
		target_time = target_time + vote_interval
		log_game("Autotransfer: New target time is [target_time]")
		current_votes++
	else
		SSshuttle.autoEnd()

/datum/controller/subsystem/autotransfer/proc/new_shift(round_start_real_time)
	start_time = round_start_real_time
	target_time = start_time + initial_vote
	log_game("Autotransfer: Autotransfer enabled, first vote in [DisplayTimeText(target_time - start_time)]")
	log_game("Autotransfer: RT:[REALTIMEOFDAY] RSRT:[SSticker.round_start_real_time] ST:[start_time] TT:[target_time] VI:[vote_interval] CV:[current_votes] MV:[max_votes] WT:[world.time] RST:[SSticker.round_start_time]")
	message_admins("Autotransfer enabled, first vote in [DisplayTimeText(target_time - start_time)]")

#undef NO_VOTE_CAP
