/obj/item/dice/d20/nat1
	rigged = DICE_BASICALLY_RIGGED
	rigged_value = 1

/obj/item/dice/d20/nat1/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/unique_examine, \
		desc = "There's a bit of extra heft to this die.", \
		desc_requirement = EXAMINE_CHECK_NONE)
