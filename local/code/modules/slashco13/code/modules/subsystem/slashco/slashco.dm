SUBSYSTEM_DEF(slashco)
	name = "SlashCo"
	flags = SS_BACKGROUND
	runlevels = RUNLEVEL_GAME
	wait = 4 SECONDS
	/// For testing purposes - if TRUE; the round can't end if all employees die. Config configurable
	var/bypass_failstate = FALSE
	/// The amount of fuel needed for each generator. Defaults to 4; but has a config value
	var/required_fuel = 4
	/// The amount of fuel that spawns on the map. Config Configurable
	var/maximum_present_fuel = 24

	/// The amount of active generators are needed for the shuttle call. Config configurable
	var/required_generators = 2
	/// How many generators are on the map? Config configurable
	var/maximum_present_generators = 3

	/// How many generators are active?
	var/active_generators = 0

	/// Have we called the shuttle via generators yet?
	var/generators_called_shuttle = FALSE

	/// What's the minimum number of items on the map? Config configurable
	var/minimum_items = 6
	/// What's the maximum number of items on the map? Config configurable
	var/maximum_items = 24

/datum/controller/subsystem/slashco/Initialize() // GOTTA MAKE IT HAPPEN.. BABY
	bypass_failstate = CONFIG_GET(flag/bypass_failstate)
	required_fuel = CONFIG_GET(number/required_fuel)
	maximum_present_fuel = CONFIG_GET(number/maximum_present_fuel)
	required_generators = CONFIG_GET(number/required_generators)
	maximum_present_generators = CONFIG_GET(number/maximum_present_generators)
	minimum_items = CONFIG_GET(number/minimum_items)
	maximum_items = CONFIG_GET(number/maximum_items)
	setup_game()
	GLOB.dynamic_forced_rulesets[/datum/dynamic_ruleset/roundstart/slashers] = RULESET_FORCE_ENABLED
	var/roundstart_rules = list()
	var/datum/dynamic_ruleset/roundstart/slashers/slasherrule = new
	roundstart_rules[slasherrule.name] = slasherrule
	GLOB.dynamic_forced_roundstart_ruleset += roundstart_rules[slasherrule.name]
	addtimer(CALLBACK(src, PROC_REF(find_valid_lobby_convo_targets)), 20 SECONDS)
	return SS_INIT_SUCCESS

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
			/obj/item/reagent_containers/cup/soda_cans/b_gone, \
			/obj/item/step_decoy, \
			/obj/item/dice/d6/devil_die, \
			/obj/item/pocket_sand, \
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

/datum/controller/subsystem/slashco/proc/queue_preroundend_check(mob/living/to_check, timer = 1 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(preroundend_check), to_check), timer)

/datum/controller/subsystem/slashco/proc/preroundend_check(mob/living/to_check)
	var/station_levels = SSmapping.levels_by_trait(ZTRAIT_STATION)
	for(var/mob/living/mob in GLOB.alive_player_list)
		if(mob.z in station_levels)
			to_chat(mob,span_cult("The walls close in; and it all goes dark..."))
			mob.gib()

/datum/controller/subsystem/slashco/fire(resumed)
	if(required_generators <= active_generators && SSshuttle.canEvac() && !generators_called_shuttle)
		SSshuttle.emergency_no_recall = TRUE
		SSshuttle.emergency.mode = SHUTTLE_IDLE
		SSshuttle.emergency.request(set_coefficient=0.10)
		generators_called_shuttle = TRUE
		for(var/mob/mob in GLOB.player_list)
			if(mob.client?.prefs.read_preference(/datum/preference/toggle/sound_announcements))
				var/possible_incoming_sounds = list(
					'local/code/modules/slashco13/sound/shuttle/approach1.ogg', \
					'local/code/modules/slashco13/sound/shuttle/approach2.ogg', \
					'local/code/modules/slashco13/sound/shuttle/approach3.ogg', \
					'local/code/modules/slashco13/sound/shuttle/approach4.ogg', \
					'local/code/modules/slashco13/sound/shuttle/approach5.ogg', \
				)
				var/our_sound = pick(possible_incoming_sounds)
				SEND_SOUND(mob, our_sound)
			/// Sid can use his gun freely at this point
			for(var/datum/antagonist/slasher/sid/sid_slasher in mob?.mind?.antag_datums)
				sid_slasher.free_toggle = TRUE
				to_chat(sid_slasher, span_cult("They'll tell everyone about your cookies. You can't have that - your full stash of bullets are available..."))
				playsound(sid_slasher, 'sound/hallucinations/im_here2.ogg', 75)
			/// Spaceman should be able to kill freely if he's in his kill phase
			for(var/datum/antagonist/slasher/spaceman/spaceman_slasher in mob?.mind?.antag_datums)
				spaceman_slasher.permanent_active_phase = TRUE
				to_chat(spaceman_slasher, span_cult("You must ascend; quickly; if you haven't already - the bell tolls..."))
				playsound(spaceman_slasher, 'sound/hallucinations/im_here2.ogg', 75)

/*
	NPC SPAWNS
*/

/obj/effect/landmark/slashco_npc_spawn
	icon_state = "tdome_admin"

/obj/effect/landmark/slashco_npc_spawn/Initialize(mapload)
	..()
	GLOB.slash_npc_spawns += loc
	return INITIALIZE_HINT_QDEL

/*
	Devil Dice Siren
*/
/datum/controller/subsystem/slashco/proc/devil_die_siren_setup(mob/living/carbon/to_fuck_over)
	var/datum/looping_sound/new_siren_to_attach = new /datum/looping_sound/devildie_siren(to_fuck_over)
	new_siren_to_attach.start(to_fuck_over)
	addtimer(CALLBACK(src, PROC_REF(devil_die_end), new_siren_to_attach), 59 SECONDS)

/// max_loops doesn't work.. lol. lmao
/datum/controller/subsystem/slashco/proc/devil_die_end(datum/looping_sound/to_end)
	to_end.stop()
	qdel(to_end)

// Less of a traditional looping sound and more of a punishment that we need to update the position of constantly
/datum/looping_sound/devildie_siren
	extra_range = 255 // can be heard everywhere; don't even try
	each_once = TRUE
	in_order = TRUE
	start_sound = 'local/code/modules/slashco13/sound/items/devildie_siren/01Siren.ogg'
	start_length = 1 SECONDS
	mid_sounds = list(
		'local/code/modules/slashco13/sound/items/devildie_siren/02Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/03Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/04Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/05Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/06Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/07Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/08Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/09Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/10Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/11Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/12Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/13Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/14Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/15Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/16Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/17Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/18Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/19Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/20Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/21Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/22Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/23Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/24Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/25Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/26Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/27Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/28Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/29Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/30Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/31Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/32Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/33Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/34Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/35Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/36Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/37Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/38Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/39Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/40Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/41Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/42Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/43Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/44Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/45Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/46Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/47Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/48Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/49Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/50Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/51Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/52Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/53Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/54Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/55Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/56Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/57Siren.ogg' = 1, \
		'local/code/modules/slashco13/sound/items/devildie_siren/58Siren.ogg' = 1, \
	)
	mid_length = 1 SECONDS
	end_sound =	'local/code/modules/slashco13/sound/items/devildie_siren/59Siren.ogg'
