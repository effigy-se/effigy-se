SUBSYSTEM_DEF(condos)
	name = "Condos"
	flags = SS_NO_FIRE
	/// All possible condo templates.
	var/list/condo_templates = list()
	/// List of active reservations we have.
	var/list/activeRooms = list()

/datum/controller/subsystem/condos/Initialize()
	preload_condo_templates()
	return SS_INIT_SUCCESS

/datum/controller/subsystem/condos/proc/preload_condo_templates()
	for(var/item in subtypesof(/datum/map_template/condo))
		var/datum/map_template/condo/condo_type = item
		if(!(initial(condo_type.mappath)))
			continue
		var/datum/map_template/condo/condo_template = new condo_type()

		condo_templates[condo_template.name] = condo_template
		SSmapping.map_templates[condo_template.name] = condo_template


/datum/controller/subsystem/condos/proc/enterActiveRoom(roomNumber, mob/user)
	if(activeRooms["[roomNumber]"])
		var/datum/turf_reservation/condo/target_active_condo = activeRooms["[roomNumber]"]
		do_sparks(3, FALSE, get_turf(user))
		var/turf/room_bottom_left = target_active_condo.bottom_left_turfs[1]
		user.forceMove(locate(
			room_bottom_left.x + target_active_condo.condo_template.landingZoneRelativeX,
			room_bottom_left.y + target_active_condo.condo_template.landingZoneRelativeY,
			room_bottom_left.z,
		))
		return TRUE
	return FALSE

/datum/controller/subsystem/condos/proc/sendToNewRoom(roomNumber, datum/map_template/condo/our_condo, mob/user, parent_object)
	if(activeRooms["[roomNumber]"])
		return // Get sanity'd
	var/datum/turf_reservation/condo/roomReservation = SSmapping.request_turf_block_reservation(our_condo.width, our_condo.height, 1)
	var/turf/bottom_left = roomReservation.bottom_left_turfs[1]

	our_condo.load(bottom_left)
	var/datum/turf_reservation/condo/our_reservation = new
	our_reservation.condo_template = our_condo
	activeRooms["[roomNumber]"] = our_reservation
	linkTurfs(roomReservation, roomNumber, parent_object)
	do_sparks(3, FALSE, get_turf(user))
	user.forceMove(locate(
		bottom_left.x + our_condo.landingZoneRelativeX,
		bottom_left.y + our_condo.landingZoneRelativeY,
		bottom_left.z,
	))

/datum/controller/subsystem/condos/proc/linkTurfs(datum/turf_reservation/condo/currentReservation, currentRoomnumber, parent_object)
	var/turf/room_bottom_left = currentReservation.bottom_left_turfs[1]
	var/area/misc/condo/currentArea = get_area(room_bottom_left)
	currentArea.name = "Condo [currentRoomnumber]"
	currentArea.parent_object = parent_object
	currentArea.roomnumber = currentRoomnumber
	currentArea.reservation = currentReservation

	for(var/turf/closed/indestructible/hoteldoor/door in currentReservation.reserved_turfs)
		door.parentSphere = parent_object
		door.desc = "The door to this condo. \
			The placard reads 'Room [currentRoomnumber]'. \
			Strangely, this door doesn't even seem openable. \
			The doorknob, however, seems to buzz with unusual energy...<br/>\
			[span_info("Alt-Click to look through the peephole.")]"
	for(var/turf/open/space/bluespace/BSturf in currentReservation.reserved_turfs)
		BSturf.parentSphere = parent_object
