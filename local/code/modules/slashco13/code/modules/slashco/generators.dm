/// LANDMARKS
/obj/effect/landmark/generator_spawn
	name = "generator spawn"
	icon_state = "x"

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
	icon = 'local/code/modules/slashco13/icons/obj/machines/generator.dmi'
	icon_state = "generator"
	base_icon_state = "generator"
	density = TRUE
	use_power = NO_POWER_USE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF // nuh uh!!

	/// Is this generator finished and activated?
	var/active = FALSE
	/// Do we have fuel attached?
	var/loaded_fuel = FALSE
	/// Do we have batteries attached?
	var/loaded_battery = FALSE
	/// The amount of fuel in this generator.
	var/fuel_count = 0
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
	set_light(1, 0.75, NONSENSICAL_VALUE)
	SSpoints_of_interest.make_point_of_interest(src)

/obj/machinery/slashco_generator/Destroy()
	QDEL_NULL(soundloop)
	return ..()

/obj/machinery/slashco_generator/examine(mob/living/user)
	. = ..()
	if(fuel_count < SSslashco.required_fuel)
		. += span_warning("Looks like it needs more fuel...")
	if(loaded_fuel)
		. += span_notice("It has a piece of fuel attached; ready to be inserted.")
		. += span_notice("Left-click on the generator to insert it.")
	if(loaded_battery)
		. += span_notice("It has a battery attached.")
	else
		. += span_warning("It's missing it's battery...")
	if(fuel_count >= SSslashco.required_fuel && loaded_battery && !active) // Inserted the battery last
		. += span_warning("Someone needs to kickstart it... maybe there's something to pull?")
	if(active)
		. += span_notice("This generator's active, and can be safely left be.")

/obj/machinery/slashco_generator/attackby(obj/item/O, mob/user, params)
	if(istype(O, fuel_path) && loaded_fuel == FALSE && fuel_count < SSslashco.required_fuel)
		var/obj/item/stack/addstack = O
		addstack.use(1)
		balloon_alert_to_viewers("Fuel Attached")
		loaded_fuel = TRUE
		playsound(src, 'local/code/modules/slashco13/sound/items/drop.ogg', 75)
		do_slasher_earlyspawn_check()
	else if(istype(O, battery_path) && loaded_battery == FALSE)
		qdel(O)
		balloon_alert_to_viewers("Battery Attached")
		loaded_battery = TRUE
		playsound(src, 'local/code/modules/slashco13/sound/items/battery_insert.ogg', 75)
		do_slasher_earlyspawn_check()
	update_appearance()

/obj/machinery/slashco_generator/proc/do_slasher_earlyspawn_check()
	for(var/datum/dynamic_ruleset/roundstart/slashers/found_ruleset in SSdynamic.executed_rules)
		if(!found_ruleset.spawned_slashers)
			found_ruleset.execute() // Early execute if someone touches the generator without slashers already in play!
		return
	message_admins("[ADMIN_LOOKUPFLW(src)] tried to check for slashers to earlyspawn; but the ruleset wasn't executed!")

/obj/machinery/slashco_generator/update_overlays()
	. = ..()
	if(loaded_fuel)
		. += "sheet"
	if(loaded_battery)
		. += "battery"
	if(active)
		. += "light_overlay"
	if(!fuel_count)
		return

	. += "fuel_[fuel_count]" // replace this with a method that checks SSslashco.required_fuel and divides by 4 to pick the overlay

/obj/machinery/slashco_generator/attack_hand(mob/living/user, list/modifiers)
	if(!user)
		return
	insertfuel(user)
	if(fuel_count >= SSslashco.required_fuel && loaded_battery && !active) // kindly fuck off
		active = 1
		SSslashco.active_generators += 1
		icon_state = "generator_on"
		soundloop.start()
		set_light(4, 0.75, LIGHT_COLOR_INTENSE_RED)
	update_appearance()

/obj/machinery/slashco_generator/proc/insertfuel(mob/living/user)
	if(loaded_fuel)
		playsound(src, 'local/code/modules/slashco13/sound/items/pickup.ogg', 100)
		balloon_alert_to_viewers("Inserting Fuel...")
		if(do_after(user, 10 SECONDS, src))
			loaded_fuel = 0
			balloon_alert_to_viewers("Fuel Inserted")
			fuel_count += 1
			do_slasher_fuel_alert()
			playsound(src, 'local/code/modules/slashco13/sound/items/drop.ogg', 100)
			if(fuel_count < SSslashco.required_fuel && loaded_battery) /// Loaded battery; but not enough fuel
				playsound(src, 'local/code/modules/slashco13/sound/machines/generator_failstart.ogg', 100)

/// This behavior was unique to generators you were ACTIVELY LOOKING AT in the OG but I felt until we port the generator HUD having it function this way is clearer as a player
/obj/machinery/slashco_generator/proc/do_slasher_fuel_alert()
	for(var/mob/living/potential_slasher in GLOB.alive_player_list)
		for(var/datum/antagonist/slasher/our_slasher_found in potential_slasher?.mind?.antag_datums) // We're a slasher; notify 'em
			if(fuel_count == SSslashco.required_fuel) // Can't check 'active' as that isn't set yet
				potential_slasher.playsound_local(get_turf(potential_slasher), 'local/code/modules/slashco13/sound/round/generator_progress_full.ogg', 75)
				continue
			// They're making progress.. find them.
			potential_slasher.playsound_local(get_turf(potential_slasher), 'local/code/modules/slashco13/sound/round/generator_progress.ogg', 75)
			continue
