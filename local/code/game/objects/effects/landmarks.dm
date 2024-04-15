/obj/effect/landmark/latejoin_interlink
	name = "JoinLateInterlink"

/obj/effect/landmark/latejoin_interlink/Initialize(mapload)
	..()
	SSjob.latejoin_interlink_trackers += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/start/broadcast_team
	name = JOB_BROADCAST_TEAM
	icon_state = JOB_ASSISTANT // I don't think we're ready for the commitment that is maintaining these as modular icons.
