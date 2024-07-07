/datum/objective_item/steal/hypo
	targetitem = /obj/item/hypospray/mkii/deluxe/cmo

/obj/item/hypospray/mkii/deluxe/cmo/add_stealing_item_objective()
	return add_item_to_steal(src, /obj/item/hypospray/mkii/deluxe/cmo)
