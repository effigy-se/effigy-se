/turf/closed/indestructible/normal_wall
	name = "wall"
	icon = 'icons/turf/walls/wall.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_WALLS + SMOOTH_GROUP_CLOSED_TURFS
	canSmoothWith = SMOOTH_GROUP_WALLS

/turf/closed/indestructible/fakedoor/blast_door
	name = /obj/machinery/door/poddoor::name
	desc = /obj/machinery/door/poddoor::desc
	icon = /obj/machinery/door/poddoor::icon
	icon_state = /obj/machinery/door/poddoor::icon_state

/turf/closed/indestructible/fakespace
	name = "space"
	desc = "You swear; you see a meteor..."
	icon = /turf/open/floor/fakespace::icon
	icon_state = /turf/open/floor/fakespace::icon_state
	layer = /turf/open/floor/fakespace::layer
	plane = /turf/open/floor/fakespace::plane
	opacity = FALSE
	gender = PLURAL
