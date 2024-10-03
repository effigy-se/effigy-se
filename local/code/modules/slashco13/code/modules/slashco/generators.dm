/// LANDMARKS
/obj/effect/landmark/generator_spawn
	name = "generator spawn"

/obj/effect/landmark/generator_spawn/Initialize(mapload)
	..()
	GLOB.genstart += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/fuel_spawn
	name = "fuel spawn"
	icon_state = "x4"

/obj/effect/landmark/fuel_spawn/Initialize(mapload)
	..()
	GLOB.fuelstart += loc
	return INITIALIZE_HINT_QDEL

/obj/effect/landmark/battery_spawn
	name = "battery spawn"
	icon_state = "x3" // x3

/obj/effect/landmark/battery_spawn/Initialize(mapload)
	..()
	GLOB.batterystart += loc
	return INITIALIZE_HINT_QDEL

/*
	The Generator
*/

/obj/machinery/slashco_generator
	name = "generator"
	desc = "Generators like these give Nanotrasen's Power Recovery team control over more of their derelicts."
	icon = 'icons/obj/machines/engine/other.dmi'
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
	var/fuel_path = /obj/item/stack/fuel
	/// Path to the battery type for this generator. Generally not changed in gameplay.
	var/battery_path = /obj/item/stock_parts/power_store/cell/lead/double_pack
	/// Soundloop for this generator
	var/datum/looping_sound/generator/soundloop

	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND

/obj/machinery/slashco_generator/Initialize(mapload)
	. = ..()
	soundloop = new(src, active)

/obj/machinery/slashco_generator/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/machinery/slashco_generator/examine(mob/living/user)
	. = ..()
	if(fuel_count <= SSslashco.required_fuel)
		. += span_warning("Looks like it needs more fuel...")
	if(loaded_fuel)
		. += span_notice("It has a piece of fuel attached; ready to be inserted.")
		. += span_notice("Left-click on the generator to insert it.")
	if(loaded_battery)
		. += span_notice("It has a battery attached.")
	else
		. += span_warning("It's missing it's battery...")
	if(active)
		. += span_notice("This generator's active, and can be safely left be.")

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
	if(fuel_count >= SSslashco.required_fuel && loaded_battery)
		active = 1
		SSslashco.active_generators += 1
		icon_state = "portgen0_1"
		soundloop.start()
	if(SSslashco.required_generators <= SSslashco.active_generators && SSshuttle.canEvac())
		SSshuttle.emergency_no_recall = TRUE
		SSshuttle.emergency.mode = SHUTTLE_IDLE
		SSshuttle.emergency.request(set_coefficient=0.10)

/obj/machinery/slashco_generator/proc/insertfuel(mob/living/user)
	if(loaded_fuel)
		balloon_alert_to_viewers("Inserting Fuel...")
		if(do_after(user, 10 SECONDS, src))
			loaded_fuel = 0
			balloon_alert_to_viewers("Fuel Inserted")
			fuel_count += 1
