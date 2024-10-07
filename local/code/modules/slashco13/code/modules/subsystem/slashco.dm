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
	addtimer(CALLBACK(src, PROC_REF(find_valid_lobby_convo_targets)), 20 SECONDS)

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

/datum/controller/subsystem/slashco/proc/queue_preroundend_check(mob/living/to_check, timer = 1 SECONDS)
	addtimer(CALLBACK(src, PROC_REF(preroundend_check), to_check), timer)

/datum/controller/subsystem/slashco/proc/preroundend_check(mob/living/to_check)
	var/station_levels = SSmapping.levels_by_trait(ZTRAIT_STATION)
	for(var/mob/living/mob in GLOB.alive_player_list)
		if(mob.z in station_levels)
			to_chat(mob,span_cult("The walls close in; and it all goes dark..."))
			mob.gib()

/*
	LOBBY CONVOS
*/

/datum/controller/subsystem/slashco/proc/find_valid_lobby_convo_targets()
	for(var/connection in GLOB.player_list)
		var/mob/player_mob = connection
		var/client/player_client = player_mob.client
		if(player_client.prefs.read_preference(/datum/preference/toggle/sound_lobby))
			addtimer(CALLBACK(src, PROC_REF(send_lobby_convo)), 15 SECONDS)
			send_lobby_convo(player_mob)

/datum/controller/subsystem/slashco/proc/send_lobby_convo(mob/our_target)
	if(prob(25)) // Not all too common but not rare either
		var/our_picked_convo = pick(typesof(/datum/lobby_conversation))
		play_lobby_convo(our_target, our_convo = our_picked_convo)

/datum/controller/subsystem/slashco/proc/play_lobby_convo(mob/our_target, var/phase = 1, datum/lobby_conversation/our_convo)
	if(our_convo && our_target)
		var/sound = /datum/lobby_conversation::sound_1
		var/length = /datum/lobby_conversation::sound_1_length
		switch(phase)
			if(1)
				sound = our_convo.sound_1
				length = our_convo.sound_1_length
			if(2)
				sound = our_convo.sound_2
				length = our_convo.sound_2_length
			if(3)
				sound = our_convo.sound_3
		our_target?.playsound_local(get_turf(our_target), sound, 75, FALSE) // possible the game is early started
		if(phase == 3)
			return
		phase++
		if(our_target) // are you still there?
			addtimer(CALLBACK(src, PROC_REF(play_lobby_convo), our_target, phase, our_convo), length)

/// DATUMS PAST HERE

/// Big Boobs / Base Type
/datum/lobby_conversation
	var/sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/bigboobs/1.ogg'
	var/sound_1_length = 2 SECONDS
	var/sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/bigboobs/2.ogg'
	var/sound_2_length = 2 SECONDS
	var/sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/bigboobs/3.ogg'

/// Abomignat
/datum/lobby_conversation/abomignat
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/abomignat/1.ogg'
	sound_1_length = 5 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/abomignat/2.ogg'
	sound_2_length = 3 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/abomignat/3.ogg'

/// Alternate Hyena
/datum/lobby_conversation/alternatehyena
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/alternatehyena/1.ogg'
	sound_1_length = 14 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/alternatehyena/2.ogg'
	sound_2_length = 2 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/alternatehyena/3.ogg'

/// Amogus (Caked Up)
/datum/lobby_conversation/amoguscaked
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/amoguscaked/1.ogg'
	sound_1_length = 4 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/amoguscaked/2.ogg'
	sound_2_length = 2 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/amoguscaked/3.ogg'

/// Ass Smack
/datum/lobby_conversation/asssmack
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/asssmack/1.ogg'
	sound_1_length = 6 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/asssmack/2.ogg'
	sound_2_length = 2 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/asssmack/3.ogg'

/// Average Discord User
/datum/lobby_conversation/avgdiscorduser
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/avgdiscorduser/1.ogg'
	sound_1_length = 3 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/avgdiscorduser/2.ogg'
	sound_2_length = 2 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/avgdiscorduser/3.ogg'

/// Bootycheeks
/datum/lobby_conversation/bootycheeks
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/bootycheeks/1.ogg'
	sound_1_length = 11 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/bootycheeks/2.ogg'
	sound_2_length = 1 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/bootycheeks/3.ogg'

/// Borgmire
/datum/lobby_conversation/borgmire
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/borgmire/1.ogg'
	sound_1_length = 12 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/borgmire/2.ogg'
	sound_2_length = 2 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/borgmire/3.ogg'

/// Distraction
/datum/lobby_conversation/distraction
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/distraction/1.ogg'
	sound_1_length = 5 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/distraction/2.ogg'
	sound_2_length = 5 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/distraction/3.ogg'

/// Elevator Smells
/datum/lobby_conversation/elevator_smells
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/elevatorsmells/1.ogg'
	sound_1_length = 3 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/elevatorsmells/2.ogg'
	sound_2_length = 4 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/elevatorsmells/3.ogg'

/// Femling (this is the one we actually have a reference to baked into the base codebase!)
/datum/lobby_conversation/femling
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/femling/1.ogg'
	sound_1_length = 7 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/femling/2.ogg'
	sound_2_length = 6 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/femling/3.ogg'

/// Gameplan
/datum/lobby_conversation/gameplan
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/gameplan/1.ogg'
	sound_1_length = 2 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/gameplan/2.ogg'
	sound_2_length = 4 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/gameplan/3.ogg'

/// Penis
/datum/lobby_conversation/penis
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/penis/1.ogg'
	sound_1_length = 2 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/penis/2.ogg'
	sound_2_length = 2 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/penis/3.ogg'

/// Power Recovery
/datum/lobby_conversation/powerrecovery
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/powerrecovery/1.ogg'
	sound_1_length = 5 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/powerrecovery/2.ogg'
	sound_2_length = 11 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/powerrecovery/3.ogg'

/// Rumpshaker
/datum/lobby_conversation/rumpshaker
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/rumpshaker/1.ogg'
	sound_1_length = 2 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/rumpshaker/2.ogg'
	sound_2_length = 2 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/rumpshaker/3.ogg'

/*
	NPC SPAWNS
*/

/obj/effect/landmark/slashco_npc_spawn
	icon_state = "tdome_admin"

/obj/effect/landmark/slashco_npc_spawn/Initialize(mapload)
	..()
	GLOB.slash_npc_spawns += loc
	return INITIALIZE_HINT_QDEL
