/obj/item/radio/intercom
	icon = 'local/icons/obj/machines/wallmounts.dmi'
	overlay_mic_active = "intercom_transmit"

/obj/item/radio/intercom/broadcast
	name = "Broadcast intercom"
	desc = "Talk at this to be heard by the whole... station."
	icon_state = "intercom_broadcast"
	icon_off = "intercom_broadcast-p"
	freerange = TRUE
	freqlock = RADIO_FREQENCY_EMAGGABLE_LOCK // Go ahead. Get silly.

/obj/item/radio/intercom/broadcast/Initialize(mapload, ndir, building)
	. = ..()
	set_frequency(FREQ_BROADCAST)
	set_broadcasting(TRUE)

MAPPING_DIRECTIONAL_HELPERS(/obj/item/radio/intercom/broadcast, 26)
