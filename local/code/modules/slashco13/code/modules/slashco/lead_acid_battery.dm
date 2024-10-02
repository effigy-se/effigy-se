/obj/item/stock_parts/power_store/cell/lead/double_pack
	name = "double-packed lead-acid battery"
	desc = "A type of primitive battery. It's absurdly large, and absurdly heavy. This is certainly the one you want."
	color = COLOR_CARP_DARK_BLUE
	w_class = WEIGHT_CLASS_HUGE
	grind_results = null // Let's not allow people to grind this fucker up considering it's important for the mode
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/stock_parts/power_store/cell/lead/double_pack/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)
	AddComponent(/datum/component/stationloving, TRUE)

/obj/item/stock_parts/power_store/cell/lead/double_pack/can_be_pulled()
	return FALSE
