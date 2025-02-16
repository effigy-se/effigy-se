/obj/item/stack/fuel
	name = "plasilicate-wrapped plasma"
	lefthand_file = 'icons/mob/inhands/items/sheets_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/sheets_righthand.dmi'
	icon_state = "sheet-plasma"
	inhand_icon_state = "sheet-plasma"
	singular_name = "plasilicate-wrapped plasma sheet"
	desc = "Specially prepared plasma sheets for use inside Nanotrasen's propreitary generators. \
	What, did you expect to be able to use normal ones? Dream on."
	color = "#949494"
	w_class = WEIGHT_CLASS_HUGE
	full_w_class = WEIGHT_CLASS_HUGE
	merge_type = /obj/item/stack/fuel
	max_amount = 1 // Aware it's slightly weird to have these be sheets with this in the picture, but use() is too good to pass up // no, past me; you're a dumbass
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	pickup_sound = 'sound/items/plastic_shield_pick_up.ogg'
	drop_sound = 'sound/items/plastic_shield_drop.ogg'

/obj/item/stack/fuel/can_be_pulled() // Coping hard, or hardly coping?
	return FALSE

/obj/item/stack/fuel/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)
	AddComponent(/datum/component/stationloving, TRUE, TRUE, TRUE)
	SSpoints_of_interest.make_point_of_interest(src)
