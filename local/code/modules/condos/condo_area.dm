/area/misc/condo
	name = "Condo"
	icon = 'icons/area/areas_ruins.dmi'
	icon_state = "hilbertshotel"
	requires_power = FALSE
	has_gravity = TRUE
	area_flags = NOTELEPORT | HIDDEN_AREA
	static_lighting = TRUE
	var/roomnumber = 0
	var/obj/machinery/interlink_condo_teleporter/parent_object
	var/datum/turf_reservation/reservation

/area/misc/condo/Exited(atom/movable/gone, direction)
	. = ..()
	if(ismob(gone))
		var/mob/M = gone
		var/stillPopulated = FALSE
		var/list/currentLivingMobs = get_all_contents_type(/mob/living) //Got to catch anyone hiding in anything
		for(var/mob/living/L in currentLivingMobs) //Check to see if theres any mobs, period; left.
			stillPopulated = TRUE
			break
		if(!stillPopulated)
			delete_room()

/area/misc/condo/proc/delete_room()
	if(isnull(reservation))
		return
	for(var/turf/turf_to_empty as anything in reservation.reserved_turfs) //remove this once clearing turf reservations is actually reliable
		turf_to_empty.empty()
	SScondos.activeRooms -= "[roomnumber]"
	qdel(reservation)
