/obj/item/scrap/apparatus
	icon_state = "apparatus"
	name = "apparatus"
	desc = "Perfectly safe to handle; though it looks like it was once hot." // I'm sorry; I had to shoehorn it

/obj/item/scrap/apparatus/randomize_credit_cost()
	return 80 // Static value

/obj/item/scrap/apparatus/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE, force_unwielded = 5, force_wielded = 5)
	set_light(4, 1.75, "#FFD800")
