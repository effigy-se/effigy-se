SUBSYSTEM_DEF(condos)
	name = "Condos"
	flags = SS_NO_FIRE
	/// All possible condo templates.
	var/list/condo_templates = list()
	/// List of active reservations we have.
	var/list/active_condos = list()
	// Items we delibrately prevent being deleted. Malleable.
	var/list/item_blacklist = list(
		/obj/item/blackbox, \
	)

/datum/controller/subsystem/condos/Initialize()
	preload_condo_templates()
	item_blacklist += typesof(/obj/item/card)
	item_blacklist += typesof(/obj/item/modular_computer)
	return SS_INIT_SUCCESS

/datum/controller/subsystem/condos/proc/preload_condo_templates()
	for(var/item in subtypesof(/datum/map_template/condo))
		var/datum/map_template/condo/condo_type = item
		if(!(initial(condo_type.mappath)))
			continue
		var/datum/map_template/condo/condo_template = new condo_type()

		condo_templates[condo_template.name] = condo_template
		SSmapping.map_templates[condo_template.name] = condo_template


/datum/controller/subsystem/condos/proc/enter_active_room(condo_number, mob/user)
	if(active_condos["[condo_number]"])
		var/datum/turf_reservation/condo/target_active_condo = active_condos["[condo_number]"]
		if(!target_active_condo)
			to_chat(user, span_redteamradio("CONDO: Room [condo_number] not found!"))
			return FALSE

		do_sparks(3, FALSE, get_turf(user))

		var/turf/room_bottom_left = target_active_condo.bottom_left_turfs[1]
		if(!room_bottom_left)
			to_chat(user, span_warning("Condo [condo_number] error. Unable to find entry turf!"))
			return FALSE

		if(user.forceMove(locate(
			room_bottom_left.x + target_active_condo.condo_template.landingZoneRelativeX,
			room_bottom_left.y + target_active_condo.condo_template.landingZoneRelativeY,
			room_bottom_left.z,
		)))
			return TRUE

	to_chat(user, span_warning("Condo [condo_number] error. Mystery failure!"))
	return FALSE

/datum/controller/subsystem/condos/proc/sendToNewRoom(condo_number, datum/map_template/condo/our_condo, mob/user, parent_object)
	if(active_condos["[condo_number]"])
		return // Get sanity'd
	var/datum/turf_reservation/condo/roomReservation = SSmapping.request_turf_block_reservation(our_condo.width, our_condo.height, 1)
	var/turf/bottom_left = roomReservation.bottom_left_turfs[1]
	if(!bottom_left)
		to_chat(user, span_warning("Failed to reserve a room for you! Contact the technical concierge."))
		return
	our_condo.load(bottom_left)
	//var/datum/turf_reservation/condo/our_reservation = new
	roomReservation.condo_template = our_condo
	active_condos["[condo_number]"] = roomReservation
	linkTurfs(roomReservation, condo_number, parent_object)
	do_sparks(3, FALSE, get_turf(user))
	user.forceMove(locate(
		bottom_left.x + our_condo.landingZoneRelativeX,
		bottom_left.y + our_condo.landingZoneRelativeY,
		bottom_left.z,
	))

/datum/controller/subsystem/condos/proc/linkTurfs(datum/turf_reservation/condo/current_reservation, condo_number, parent_object)
	var/turf/room_bottom_left = current_reservation.bottom_left_turfs[1]
	var/area/misc/condo/current_area = get_area(room_bottom_left)
	current_area.name = "Condo [condo_number]"
	current_area.parent_object = parent_object
	current_area.condo_number = condo_number
	current_area.reservation = current_reservation

	for(var/turf/closed/indestructible/hoteldoor/door in current_reservation.reserved_turfs)
		door.parentSphere = parent_object
		door.desc = "The door to this condo. \
			The placard reads 'Room [condo_number]'. \
			Strangely, this door doesn't even seem openable. \
			The doorknob, however, seems to buzz with unusual energy...<br/>\
			[span_info("Alt-Click to look through the peephole.")]"
	for(var/turf/open/space/bluespace/bluespace_turf in current_reservation.reserved_turfs)
		bluespace_turf.parentSphere = parent_object
