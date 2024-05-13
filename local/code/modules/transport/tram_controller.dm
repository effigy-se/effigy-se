/datum/transport_controller/linear/tram/New(obj/structure/transport/linear/tram/transport_module)
	. = ..()
	RegisterSignal(SSticker, COMSIG_TICKER_ROUND_STARTING, PROC_REF(round_start))

/datum/transport_controller/linear/tram/proc/round_start()
	SIGNAL_HANDLER

	cycle_doors(CYCLE_OPEN)
	UnregisterSignal(SSticker, COMSIG_TICKER_ROUND_STARTING)

/obj/machinery/transport/tram_controller/sigma_octantis
	configured_transport_id = SIGMA_OCTANTIS_LINE_1
