/obj/structure/bed/pod/Initialize(mapload)
	. = ..()
	new /obj/structure/bed/roller(loc)
	qdel(src)
