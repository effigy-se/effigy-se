/obj/machinery/computer/security/telescreen/entertainment
	var/obj/item/radio/radio

/obj/machinery/computer/security/telescreen/entertainment/Initialize(mapload)
	. = ..()
	radio = new /obj/item/radio(src.loc)
	radio.invisibility = 100
	radio.anchored = TRUE
	radio.set_broadcasting(FALSE)
	radio.set_frequency(FREQ_BROADCAST)
	if(!network.len)
		radio.set_listening(FALSE)

/obj/machinery/computer/security/telescreen/entertainment/Destroy()
	if(radio)
		QDEL_NULL(radio)
	return ..()

/obj/machinery/computer/security/telescreen/entertainment/update_shows(is_show_active, tv_show_id, announcement)
	. = ..()
	radio.forceMove(src.loc)
	if(!network.len || !is_show_active)
		radio.set_listening(FALSE)
	else if(is_show_active)
		radio.set_listening(TRUE)
