/obj/item/stock_parts/power_store/cell/lead/double_pack
	name = "double-packed lead-acid battery"
	desc = "A type of primitive battery. It's absurdly large, and absurdly heavy. This is certainly the one you want."
	w_class = WEIGHT_CLASS_HUGE
	grind_results = null // Let's not allow people to grind this fucker up considering it's important for the mode
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	pickup_sound = 'local/code/modules/slashco13/sound/items/pickup.ogg'
	drop_sound = 'local/code/modules/slashco13/sound/items/drop.ogg'

/obj/item/stock_parts/power_store/cell/lead/double_pack/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)
	AddComponent(/datum/component/stationloving, TRUE, TRUE, TRUE)
	SSpoints_of_interest.make_point_of_interest(src)

/obj/item/stock_parts/power_store/cell/lead/double_pack/can_be_pulled()
	return FALSE

// For SlashCo Only
/obj/item/stock_parts/power_store/cell/lead/Initialize(mapload)
	. = ..()
	if(!istype(src, /obj/item/stock_parts/power_store/cell/lead/double_pack))
		qdel(src)
