/turf/closed/mineral/random/jungle
	baseturfs = /turf/open/misc/rough_stone
	turf_type = /turf/open/misc/dirt/jungle // Used exclusively by rivergen; shit sucks

/turf/closed/mineral/random/jungle/mineral_chances()
	return list(
		/obj/item/boulder/gulag = 165,
		/turf/closed/mineral/gibtonite = 2,
	)
