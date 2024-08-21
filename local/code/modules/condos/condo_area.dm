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
	// Items we delibrately prevent being deleted. Malleable.
	var/list/item_blacklist = list(
		/obj/item/blackbox, \
	)

/area/misc/condo/Initialize(mapload)
	. = ..()
	item_blacklist += typesof(/obj/item/card)
	item_blacklist += typesof(/obj/item/modular_computer)


/area/misc/condo/Exited(atom/movable/gone, direction)
	. = ..()
	if(ismob(gone))
		var/stillPopulated = FALSE
		var/list/currentLivingMobs = get_all_contents_type(/mob/living) //Got to catch anyone hiding in anything
		for(var/mob/living/L in currentLivingMobs) //Check to see if theres any living mobs, period; left.
			stillPopulated = TRUE
			break
		if(!stillPopulated)
			delete_room()

/area/misc/condo/proc/delete_room()
	var/list/all_atoms = get_all_contents()
	for(var/atom/movable/blacklisted_atom in item_blacklist)
		if(blacklisted_atom in all_atoms)
			blacklisted_atom.forceMove(get_turf(parent_object))
	if(isnull(reservation))
		return
	for(var/turf/turf_to_empty as anything in reservation.reserved_turfs) //remove this once clearing turf reservations is actually reliable
		turf_to_empty.empty()
	SScondos.activeRooms -= "[roomnumber]"
	qdel(reservation)
