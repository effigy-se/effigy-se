/obj/structure/fluff/fake_firedoor
	name = /obj/machinery/door/firedoor::name
	desc = /obj/machinery/door/firedoor::desc
	icon = /obj/machinery/door/firedoor::icon
	icon_state = /obj/machinery/door/firedoor::icon_state
	layer = /obj/machinery/door/firedoor::layer
	alpha = 64
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT

/obj/structure/fluff/fake_firedoor/Initialize(mapload)
	. = ..()
	icon_state = "door_open_top"
	. += mutable_appearance(icon, "door_open_bottom", ABOVE_MOB_LAYER, appearance_flags = KEEP_APART)

/obj/structure/fluff/fake_transit_tube
	name = /obj/structure/transit_tube::name
	desc = /obj/structure/transit_tube::desc
	icon = /obj/structure/transit_tube::icon
	icon_state = /obj/structure/transit_tube::icon_state
	layer = /obj/structure/transit_tube::layer
	density = /obj/structure/transit_tube::density
	pass_flags_self = /obj/structure/transit_tube::pass_flags_self

