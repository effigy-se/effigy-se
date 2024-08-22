// Subtype that mimics more traditional airlocks.
/turf/closed/indestructible/hoteldoor/fakedoor
	name = "Condo Door"
	icon = 'icons/obj/doors/airlocks/tall/centcom.dmi'
	icon_state = "fake_door"
	smoothing_flags = NONE
	leave_message = "Are you ready to leave the Condo? If all occupants vacate; it'll be reset and anything you leave behind'll be lost!"
	true_wall_turf = FALSE
	use_splitvis = FALSE
	/// What kind of turf should be visually represented under this door?
	var/turf/floor_to_copy = /turf/open/floor/plating

/turf/closed/indestructible/hoteldoor/fakedoor/Initialize(mapload)
	. = ..()
	underlays += mutable_appearance(initial(floor_to_copy.icon), initial(floor_to_copy.icon_state), initial(floor_to_copy.layer), offset_spokesman = src, plane = FLOOR_PLANE)
