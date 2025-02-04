/obj/item/scrap/micro_generator
	icon_state = "micro_generator"
	name = "\improper NTHI generator replica"
	desc = "A micro-sized replica of the generators the Power Recovery team work with. Nonfunctional."
	force = 5

/obj/item/scrap/micro_generator/randomize_credit_cost()
	return rand(33, 99)

/obj/item/scrap/micro_generator/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/two_handed, require_twohands = TRUE, force_unwielded = 5, force_wielded = 5)
