/obj/machinery/door/window/tram/platform
	name = "platform door"
	desc = "Keeps idiots like you from walking onto the tram tracks."
	icon_state = "left"
	base_state = "left"
	can_atmos_pass = ATMOS_PASS_DENSITY // shaft is airtight when closed
	req_access = list(ACCESS_TCOMMS)
	/// Weakref to the tram we're attached
	var/datum/weakref/transport_ref
	autoclose = FALSE
	var/platform_linked_code

/obj/machinery/door/window/tram/platform/right
	icon_state = "left"
	base_state = "left"

/obj/machinery/door/window/tram/platform/right
	icon_state = "right"
	base_state = "right"

/obj/machinery/door/window/tram/platform/Initialize(mapload)
	. = ..()
	if(!id_tag)
		id_tag = assign_random_name()
	RemoveElement(/datum/element/atmos_sensitive, mapload)
	return INITIALIZE_HINT_LATELOAD

/obj/machinery/door/window/tram/platform/LateInitialize(mapload)
	. = ..()
	//INVOKE_ASYNC(src, PROC_REF(open))
	SStransport.platform_doors += src
	find_tram()

/obj/machinery/door/window/tram/platform/Destroy()
	SStransport.platform_doors -= src
	return ..()

/**
 * Set the weakref for the tram we're attached to
 */
/obj/machinery/door/window/tram/platform/proc/find_tram()
	for(var/datum/transport_controller/linear/tram/tram as anything in SStransport.transports_by_type[TRANSPORT_TYPE_TRAM])
		if(tram.specific_transport_id == transport_linked_id)
			transport_ref = WEAKREF(tram)

/obj/machinery/door/window/tram/platform/proc/validate_position(platform_code, travel_remaining)
	if(travel_remaining || platform_code != platform_linked_code)
		close()
	else
		open()

/datum/transport_controller/linear/tram/cycle_doors(door_status, rapid)
	. = ..()
	for(var/obj/machinery/door/window/tram/platform/platform_door as anything in SStransport.platform_doors)
		if(platform_door.transport_linked_id == specific_transport_id)
			INVOKE_ASYNC(platform_door, TYPE_PROC_REF(/obj/machinery/door/window/tram/platform, validate_position), idle_platform.platform_code, travel_remaining)

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/tram/platform/left, 0)
MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/door/window/tram/platform/right, 0)

