SUBSYSTEM_DEF(slashco)
	name = "SlashCo"
	flags = SS_NO_FIRE
	runlevels = RUNLEVEL_GAME
	/// For testing purposes - if TRUE; the round can't end if all employees die. Config configurable
	var/bypass_failstate = FALSE
	/// The amount of fuel needed for each generator. Defaults to 3; but has a config value
	var/required_fuel = 4
	/// The amount of fuel that spawns on the map. Config Configurable
	var/maximum_present_fuel = 24

	/// The amount of active generators are needed for the shuttle call. Config configurable
	var/required_generators = 2
	/// How many generators are on the map? Config configurable
	var/maximum_present_generators = 3

	/// How many generators are active?
	var/active_generators = 0

	/// What's the minimum number of items on the map? Config configurable
	var/minimum_items = 6
	/// What's the maximum number of items on the map? Config configurable
	var/maximum_items = 24

	/// What's the maximum amount of Slashers? Defaults to 1; but scales for every 8 players (Unimplemented yet; same with configs above. Saving those for later)
	var/maximum_slashers = 1

/datum/controller/subsystem/slashco/Initialize() // GOTTA MAKE IT HAPPEN.. BABY
	setup_game()
	GLOB.dynamic_forced_rulesets[/datum/dynamic_ruleset/roundstart/slashers] = RULESET_FORCE_ENABLED
	var/roundstart_rules = list()
	var/datum/dynamic_ruleset/roundstart/slashers/slasherrule = new
	roundstart_rules[slasherrule.name] = slasherrule
	GLOB.dynamic_forced_roundstart_ruleset += roundstart_rules[slasherrule.name]

/datum/controller/subsystem/slashco/proc/setup_game()
	/// Handle generators first; they have batteries as a dependant
	for(var/integer=1 to maximum_present_generators)
		var/OurGenerator = pick(GLOB.genstart)
		if(!OurGenerator)
			CRASH("There are no possible generator spawns!")
		GLOB.genstart -= OurGenerator
		new /obj/machinery/slashco_generator(OurGenerator)
	/// Handle fuel spawning second
	for(var/integer=1 to maximum_present_fuel)
		var/OurSheet = pick(GLOB.fuelstart)
		if(!OurSheet)
			CRASH("There are no possible fuel spawns!")
		GLOB.fuelstart -= OurSheet
		new /obj/item/stack/fuel(OurSheet)
	/// Handle Batteries third
	for(var/integer=1 to maximum_present_generators)
		for(var/workable_location in GLOB.batterystart) // yucky double for() but I couldn't think of a saner way to do this
			var/area/potential_spot = get_area(workable_location)
			if(!potential_spot)
				continue
			for(var/obj/machinery/slashco_generator/found_generator in potential_spot.contents)
				GLOB.batterystart -= workable_location
				new /obj/item/stock_parts/power_store/cell/lead/double_pack(workable_location)
				continue
	/// Handle Items Last
	for(var/integer=1 to rand(minimum_items,maximum_items))
		var/OurItem = pick(GLOB.slashitemstart)
		GLOB.slashitemstart -= OurItem
		var/list/possibleslashcoitems = list(
			/obj/item/toy/faustian_doll, \
			/obj/item/food/meat/lab_grown, \
			/obj/item/reagent_containers/condiment/mayonnaise/slashco, \
			/obj/item/food/cookie, \
			/obj/item/reagent_containers/cup/soda_cans/b_gone \
		)
		var/our_selection = pick(possibleslashcoitems)
		new our_selection(OurItem)

/datum/controller/subsystem/slashco/proc/can_call_early()
	if(active_generators >= (required_generators * 0.5))
		return TRUE
	var/alive_nonantag_crew = 0
	for(var/datum/mind/potential_escapee in SSticker.minds)
		if(potential_escapee.antag_datums != null)
			continue
		alive_nonantag_crew += 1
	if(alive_nonantag_crew <= 1) // EXACTLY one person left (or less; somehow)
		return TRUE
	return FALSE

/*
	NPC SPAWNS
*/

/obj/effect/landmark/slashco_npc_spawn
	icon_state = "tdome_admin"

/obj/effect/landmark/slashco_npc_spawn/Initialize(mapload)
	..()
	GLOB.slash_npc_spawns += loc
	return INITIALIZE_HINT_QDEL
