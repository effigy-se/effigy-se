/obj/machinery/slashco_generator
	name = "Generator"
	icon = 'icons/obj/power.dmi'
	icon_state = "portgen0_0"
	base_icon_state = "portgen0"
	density = TRUE
	use_power = NO_POWER_USE

	var/active = FALSE
	var/fuel_count
	var/datum/looping_sound/generator/soundloop

	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND

/obj/machinery/slashco_generator/Initialize(mapload)
	. = ..()
	soundloop = new(src, active)

/obj/machinery/slashco_generator/Destroy()
	QDEL_NULL(soundloop)
	return ..()
