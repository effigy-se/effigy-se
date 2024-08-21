// Subtype that mimics more traditional airlocks.
/turf/closed/indestructible/hoteldoor/fakedoor // Keep in mind this still inherits the glow animation from parent. I initially disliked it but.. ehhh not worth fighting
	name = "Condo Door"
	icon = 'icons/obj/doors/airlocks/tall/centcom.dmi'
	icon_state = "fake_door"
	smoothing_flags = NONE
	/// What kind of turf should be visually represented under this door?
	var/turf/floor_to_copy = /turf/open/floor/plating

/turf/closed/indestructible/hoteldoor/fakedoor/Initialize(mapload)
	.. = ..()
	underlays += mutable_appearance(initial(floor_to_copy.icon), initial(floor_to_copy.icon_state), initial(floor_to_copy.layer), offset_spokesman = src, plane = FLOOR_PLANE)
