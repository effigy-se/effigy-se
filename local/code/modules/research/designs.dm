/datum/design/vox_gas_filter
	name = "Vox Gas Filter"
	id = "vox_gas_filter"
	build_type = PROTOLATHE | AUTOLATHE
	materials = list(/datum/material/iron = 100)
	build_path = /obj/item/gas_filter/vox
	category = list(
		RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_GAS_TANKS
	)
	departmental_flags = ALL

/datum/design/pen
	name = "Pen"
	id = "pen"
	build_type = AUTOLATHE
	materials = list(/datum/material/iron = 32, /datum/material/glass = 8)
	build_path = /obj/item/pen
	category = list(RND_CATEGORY_INITIAL, RND_CATEGORY_EQUIPMENT + RND_SUBCATEGORY_EQUIPMENT_MISC)
