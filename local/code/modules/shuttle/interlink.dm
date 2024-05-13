/obj/machinery/computer/shuttle/interlink
	name = "Blaster Console"
	desc = "Used to control the Interlink ferry."
	circuit = /obj/item/circuitboard/computer/interlink
	shuttleId = "interlink"
	possible_destinations = "interlink_home;ferry_home"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF // nuh uh!!

/obj/machinery/door/airlock/external/ruin/interlink_ferry
	var/searched_trait = ZTRAIT_CENTCOM

/obj/machinery/door/airlock/external/ruin/interlink_ferry/opens_at_station
	searched_trait = ZTRAIT_STATION

/obj/machinery/door/airlock/external/ruin/interlink_ferry/post_machine_initialize()
	. = ..()
	shuttle_boltcycle()

/obj/machinery/door/airlock/external/ruin/interlink_ferry/onShuttleMove(turf/newT, turf/oldT, list/movement_force, move_dir, obj/docking_port/stationary/old_dock, obj/docking_port/mobile/moving_dock)
	. = ..()
	shuttle_boltcycle()

/obj/machinery/door/airlock/external/ruin/interlink_ferry/proc/shuttle_boltcycle()
	var/datum/space_level/level = SSmapping.z_list[z]
	if(!level)
		return
	if(searched_trait in level.traits)
		open()
		unbolt()
	else
		close()
		bolt()
