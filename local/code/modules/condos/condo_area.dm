/area/misc/condo
	name = "Condo"
	icon = 'icons/area/areas_ruins.dmi'
	icon_state = "hilbertshotel"
	requires_power = FALSE
	has_gravity = TRUE
	area_flags = NOTELEPORT | HIDDEN_AREA
	static_lighting = TRUE
	var/condo_number = 0
	var/obj/machinery/interlink_condo_teleporter/parent_object
	var/datum/turf_reservation/reservation

/area/misc/condo/Exited(atom/movable/gone, direction)
	. = ..()
	if(ismob(gone))
		var/condo_still_rockin = FALSE
		var/list/living_mobs = get_all_contents_type(/mob/living) //Got to catch anyone hiding in anything
		for(var/mob/living/living_mob in living_mobs) //Check to see if theres any living mobs, period; left.
			condo_still_rockin = TRUE
			break

		if(condo_still_rockin)
			dont_come_knockin()
		else
			clean_room()

/area/misc/condo/proc/dont_come_knockin(atom/movable/gone)
	log_game("[gone] has left condo [condo_number]")

/area/misc/condo/proc/clean_room(atom/movable/gone)
	log_game("[gone] has left condo [condo_number]")
	delete_room()

/area/misc/condo/proc/delete_room()
	var/list/all_atoms = get_all_contents()
	for(var/atom/movable/potential_blacklisted_atom in all_atoms)
		if(is_type_in_list(potential_blacklisted_atom, SScondos.item_blacklist))
			potential_blacklisted_atom.forceMove(get_turf(parent_object))
	if(isnull(reservation))
		return
	for(var/turf/turf_to_empty as anything in reservation.reserved_turfs) //remove this once clearing turf reservations is actually reliable
		turf_to_empty.empty()
	SScondos.active_condos -= "[condo_number]"
	qdel(reservation)
