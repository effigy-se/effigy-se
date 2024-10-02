/datum/dynamic_ruleset/roundstart/slashers
	name = "Slashers"
	persistent = TRUE
	antag_flag = ROLE_SLASHER
	antag_datum = /datum/antagonist/slasher
	weight = INFINITY // the name of GOD
	delay = 7 MINUTES
	requirements = list(0,0,0,0,0,0,0,0,0,0)
	antag_cap = 1
	scaling_cost = 20
	flags = ONLY_RULESET

/datum/dynamic_ruleset/roundstart/slashers/rule_process()
	var/winner = process_victory()
	if (isnull(winner))
		return

	if(winner == TRUE)
		GLOB.revolutionary_win = TRUE // we can just hijack the revolution victory lol
		for(var/mob/target in GLOB.player_list)
			if(!isnewplayer(target))
				SEND_SOUND(target, 'local/code/modules/slashco13/sound/music/lost.ogg')

	return RULESET_STOP_PROCESSING

/datum/dynamic_ruleset/roundstart/slashers/proc/process_victory()
	for(var/datum/antagonist/slasher/antagge as anything in GLOB.antagonists)
		for(var/datum/objective/assassinate/objective in antagge.objectives)
			if(!(objective.check_completion()))
				return FALSE
		return TRUE

/datum/dynamic_ruleset/roundstart/slashers/pre_execute(population)
	. = ..()
	for (var/i in 1 to SSslashco.maximum_slashers)
		var/got_one = FALSE // prevents game resets so long as there's at least ONE slasher
		if(candidates.len <= 0 && !got_one) // This shouldn't happen; the round is bricked. Restart
			to_chat(world,span_announce("Restarting the server - no valid Slashers!"))
			GLOB.revolutionary_win = TRUE // it's just that easy chief
			break
		var/mob/M = pick_n_take(candidates)
		assigned += M.mind
		M.mind.restricted_roles = restricted_roles
		M.mind.special_role = ROLE_SLASHER
		GLOB.pre_setup_antags += M.mind
		got_one = TRUE
	return TRUE

/datum/dynamic_ruleset/roundstart/slashers/execute()
	var/list/possible_slashers = subtypesof(antag_datum)
	to_chat(world, "possible slasher: [possible_slashers]")
	var/a_bite = FALSE
	for(var/datum/mind/new_slasher in assigned)
		to_chat(world, "new slasher: [new_slasher]")
		var/our_slasher_type = pick_n_take(possible_slashers)
		to_chat(world, "our slasher type: [our_slasher_type]")
		if(!our_slasher_type)
			to_chat(world, "ran out of slashers. resetting")
			possible_slashers = subtypesof(antag_datum)
			our_slasher_type = pick_n_take(possible_slashers)
		var/datum/antagonist/slasher/new_antag_datum = new our_slasher_type
		new_slasher.add_antag_datum(new_antag_datum)
		var/potential_spawn = find_space_spawn()
		if(!potential_spawn)
			to_chat(world, "no potential safe spawns")
			potential_spawn = get_safe_random_station_turf() /// No carpspawns? Fuggit; random safe tile
		new_slasher.current.forceMove(potential_spawn)
		GLOB.pre_setup_antags -= new_slasher
		a_bite = TRUE
	if(a_bite)
		return TRUE
	else
		to_chat(world, span_announce("Failed to set up game - no eligible Slashers! Check your antagonist preferences - server rebooting shortly..."))
		GLOB.revolutionary_win = TRUE
		return FALSE
