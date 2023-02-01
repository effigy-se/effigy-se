/obj/effect/landmark/generator_spawn
	name = "generator spawn"

/obj/effect/landmark/generator_spawn/Initialize(mapload)
	..()
	GLOB.genstart += loc
	return INITIALIZE_HINT_QDEL

/// Generator ///
/obj/machinery/slashco_generator
	name = "Generator"
	icon = 'icons/obj/power.dmi'
	icon_state = "portgen0_0"
	base_icon_state = "portgen0"
	density = TRUE
	use_power = NO_POWER_USE

	/// Is this generator finished and activated?
	var/active = FALSE
	/// Do we have fuel attached?
	var/loaded_fuel = FALSE
	/// Do we have batteries attached?
	var/loaded_battery = FALSE
	/// The amount of fuel in this generator.
	var/fuel_count
	/// Path to the fuel type for this generator. Generally not changed in gameplay.
	var/fuel_path = /obj/item/stack/sheet/mineral/plasma
	/// Path to the battery type for this generator. Generally not changed in gameplay.
	var/battery_path = /obj/item/stock_parts/cell/bluespace
	/// Soundloop for this generator
	var/datum/looping_sound/generator/soundloop

	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND

/obj/machinery/slashco_generator/Initialize(mapload)
	. = ..()
	soundloop = new(src, active)

/obj/machinery/slashco_generator/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/machinery/slashco_generator/attackby(obj/item/O, mob/user, params)
	if(istype(O, fuel_path) && loaded_fuel == FALSE)
		var/obj/item/stack/addstack = O
		addstack.use(1)
		balloon_alert_to_viewers("Fuel Attached")
		loaded_fuel = TRUE
	else if(istype(O, battery_path) && loaded_battery == FALSE)
		qdel(O)
		balloon_alert_to_viewers("Battery Attached")
		loaded_battery = TRUE

/obj/machinery/slashco_generator/attack_hand(mob/living/user, list/modifiers)
	if(!user)
		return
	insertfuel(user)
	if(fuel_count >= GLOB.required_fuel)
		active = 1
		GLOB.active_generators += 1
		update_appearance()
		soundloop.start()

/obj/machinery/slashco_generator/var/insertfuel(mob/living/user)
	if(loaded_fuel)
		balloon_alert_to_viewers("Inserting Fuel...")
		if(do_after(user, 10, src))
			loaded_fuel = 0
			balloon_alert_to_viewers("Fuel Inserted")
			fuel_count += 1
