/obj/structure/closet/secure_closet/event_venue_do_not_use_off_interlink_event_venue // yeah this is a theme now
	name = "event venue staff closet"
	desc = "all you need to run a successful pizza party (instead of increasing wages.)"
	req_access = list(ACCESS_CENT_CAPTAIN)
	anchored = TRUE

/obj/structure/closet/secure_closet/event_venue/PopulateContents()
	..()
	new /obj/item/door_remote/omni/admin(src)
