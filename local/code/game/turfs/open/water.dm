/turf/open/water/attackby(obj/item/C, mob/user, params, area/area_restriction)
	..()
	if(istype(C, /obj/item/stack/rods))
		var/obj/item/stack/rods/R = C
		var/obj/structure/lattice/L = locate(/obj/structure/lattice, src)
		if(L)
			return
		if(!R.use(1))
			to_chat(user, span_warning("You need one rod to build a lattice."))
			return
		to_chat(user, span_notice("You construct a lattice."))
		playsound(src, 'sound/weapons/genhit.ogg', 50, TRUE)
		// Create a lattice, without reverting to our baseturf
		new /obj/structure/lattice(src)
		return
	else if(istype(C, /obj/item/stack/tile/iron))
		build_with_floor_tiles(C, user)

/turf/open/water/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.mode == RCD_TURF && the_rcd.rcd_design_path == /turf/open/floor/plating/rcd)
		return list("delay" = 0, "cost" = 3)
	return FALSE

/turf/open/water/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, list/rcd_data)
	if(rcd_data["[RCD_DESIGN_MODE]"] == RCD_TURF && rcd_data["[RCD_DESIGN_PATH]"] == /turf/open/floor/plating/rcd)
		ChangeTurf(/turf/open/floor/plating, flags = CHANGETURF_INHERIT_AIR)
		return TRUE
	return FALSE
