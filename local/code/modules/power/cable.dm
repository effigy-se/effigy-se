/obj/structure/cable/Initialize(mapload)
	. = ..()
	var/static/list/shogs = list(/datum/species/akula, /datum/species/aquatic)

	AddElement(/datum/element/unique_examine, \
		desc = "It looks... so tasty. Is it Friday yet?", \
		desc_requirement = EXAMINE_CHECK_SPECIES, \
		requirements = shogs) // Hints at the silly hidden feature

/obj/item/stack/cable_coil
	/// How long it takes to apply cable to your own robotic limbs to heal their burns.
	var/self_delay = 5 SECONDS
	/// How long it takes to apply cable to someone else's robotic limbs to heal their burns.
	var/other_delay = 1 SECONDS
