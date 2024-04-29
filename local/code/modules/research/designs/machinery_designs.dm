/datum/design/time_clock_frame
	name = "Time Clock Frame"
	desc = "A frame for a time clock console, contains all of the parts needed to build a new time clock"
	id = "time_clock_frame"
	build_type = PROTOLATHE
	materials = list(/datum/material/iron = 4000, /datum/material/glass = 2000)
	build_path = /obj/item/wallframe/time_clock
	category = list(RND_CATEGORY_MACHINE)
	departmental_flags = DEPARTMENT_BITFLAG_ENGINEERING | DEPARTMENT_BITFLAG_SERVICE
