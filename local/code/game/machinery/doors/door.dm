/obj/machinery/door/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/sliding_under) // For drones
