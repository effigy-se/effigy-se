/obj/item/stack/fuel
	name = "plasilicate-wrapped plasma"
	icon_state = "sheet-plasma"
	inhand_icon_state = "sheet-plasma"
	singular_name = "plasma sheet"
	desc = "Specially prepared plasma sheets for use inside Nanotrasen's propreitary generators. \
	What, did you expect to be able to use normal ones? Dream on."
	color = "#949494"
	w_class = WEIGHT_CLASS_HUGE
	merge_type = /obj/item/stack/fuel
	max_amount = 1 // Aware it's slightly weird to have these be sheets with this in the picture, but use() is too good to pass up
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF

/obj/item/stack/fuel/can_be_pulled() // Coping hard, or hardly coping?
	return FALSE

/obj/item/stack/fuel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)
