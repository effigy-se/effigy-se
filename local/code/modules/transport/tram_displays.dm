/obj/machinery/transport/destination_sign/sigma_octantis
	icon = 'local/icons/obj/tram/tram_display.dmi'
	configured_transport_id = SIGMA_OCTANTIS_LINE_1

/obj/machinery/transport/destination_sign/indicator/sigma_octantis
	icon = 'local/icons/obj/tram/tram_indicator.dmi'
	configured_transport_id = SIGMA_OCTANTIS_LINE_1

/obj/machinery/transport/destination_sign/Initialize(mapload)
	. = ..()
	LAZYADD(available_faces, SIGMA_OCTANTIS_LINE_1)
