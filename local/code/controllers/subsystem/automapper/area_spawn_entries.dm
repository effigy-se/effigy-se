// Structures
/datum/area_spawn/lustwish_public
	target_areas = list(/area/station/commons/locker, /area/station/commons/dorms/laundry, /area/station/commons/dorms)
	desired_atom = /obj/machinery/vending/dorms
	mode = AREA_SPAWN_MODE_HUG_WALL

/datum/area_spawn/lustwish_prison
	target_areas = list(/area/station/security/prison, /area/station/security/prison/shower)
	desired_atom = /obj/machinery/vending/dorms
	mode = AREA_SPAWN_MODE_HUG_WALL
