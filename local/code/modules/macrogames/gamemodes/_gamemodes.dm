/// We handle gameplay logic on the datum level rather than on SSMacrogames to allow for modularity
/datum/macrogame_gamemode
	var/name = "Untitled Gamemode"
	var/description = "A bunch of people on a space station wonder why the round isn't working correctly."

	/// Can we run this gamemode midround?
	var/can_be_run_midround = TRUE

	/// Should we process this gamemode? Independent of forced rulesets.
	var/should_process = FALSE

	/// Should we force any dynamic rulesets?
	var/list/rulesets_to_force = list()

	/// What events should we prevent from running?
	var/blacklisted_events = list()

	/// JOB STUFF ///
	/// What jobs should we allow?
	var/whitelisted_jobs = list()

	/// Should we prevent latejoining?
	var/prevent_latejoins = TRUE // SHOG TODO

	/// TITLE STUFF ///
	/// The Splash HTML we want to use for this gamemode, if any. NULL Uses codebase default.
	var/replacement_splash_html
	/// Possible main menu images for this gamemode.
	var/main_menu_images = list()


	/// MAPPING STUFF ///
	/// Do we ONLY run on maps with the apropriate mapflags?
	var/requires_mapflags = FALSE

	/// BASEGAME OVERRIDES ///


	/// MOBS ///

	/// If TRUE; we set negative moodlets to have 0 effect.
	var/anull_negative_moodles = FALSE


	/// LOBBY ///

	/// Player requirement! The lobby won't start the game under this many people. Should be a minimum of 1.
	var/required_players = 1

	/// The sounds we play if the lobby's delayed.
	var/list/lobby_delay_sounds = list()


	/// COMMAND REPORT ///

	/// The minimum amount of time it takes before a roundstart command report appears. Overrides SSdynamic.waittime_l
	var/roundstart_command_report_low_waittime

	/// The minimum amount of time it takes before a roundstart command report appears. Overrides SSdynamic.waittime_h
	var/roundstart_command_report_high_waittime

	/// What we replace the roundstart command report to; if anything.
	var/roundstart_command_report_text

	/// What our roundstart command title is.
	var/roundstart_command_report_title

	/// Roundstart Command Report sounds.
	var/list/roundstart_command_report_sounds = list()

	/// EMERGENCY SHUTTLE ///

	/// How long do we want the emergency shuttle to take to dock at the station?
	var/desired_emergency_dock_time

	/// How long do we want the emergency shuttle to take to leave the station?
	var/desired_emergency_escape_time

	/// The engine coefficient for the emergency shuttle; if we want to force it.
	var/desired_shuttle_coefficient

/datum/macrogame_gamemode/New()
	if(do_can_run_checks())
		SSmacrogames.running_gamemodes += src
		do_gamemode_setup()
	else
		SSmacrogames.queued_gamemodes += src

/datum/macrogame_gamemode/Destroy(force)
	if(whitelisted_jobs)
		SSjob.joinable_occupations = SSmacrogames.joinable_occupations_copy.Copy()
		SSmacrogames.joinable_occupations_copy = list()
	if(src in SSmacrogames.running_gamemodes)
		SSmacrogames.running_gamemodes -= src
	if(src in SSmacrogames.queued_gamemodes)
		SSmacrogames.queued_gamemodes -= src
	. = ..()

/// Override to replace the checks needed to see if you can run any given gamemode this round.
/datum/macrogame_gamemode/proc/do_can_run_checks()
	if((!SSticker.HasRoundStarted() || can_be_run_midround) && (!requires_mapflags || (name in SSmapping.config?.gamemode_mapflags)))
		return TRUE
	return FALSE

/// The 'master' gamemode logic runthrough; to keep things relatively simple.
/datum/macrogame_gamemode/proc/do_gamemode_setup()

	if(replacement_splash_html) // HIGHLY RECCOMENDED: vet who has access to your config folder; especially if they can edit or upload. SStitle HAS BEEN an attack vector.
		if(fexists("[global.config.directory]/[initial(replacement_splash_html)].txt"))
			SStitle.title_html = file2text("[global.config.directory]/[initial(replacement_splash_html)].txt")

	if(main_menu_images)
		SStitle.change_title_screen(pick(main_menu_images))

	if(blacklisted_events)
		for(var/datum/round_event_control/possible_event in blacklisted_events)
			if(possible_event in SSevents.control)
				SSevents.control -= possible_event

	if(whitelisted_jobs)
		SSmacrogames.joinable_occupations_copy = SSjob.joinable_occupations.Copy()
		for(var/datum/job/found_job in SSjob.joinable_occupations)
			if(found_job in whitelisted_jobs)
				continue
			SSjob.joinable_occupations -= found_job

	if(rulesets_to_force)
		force_rulesets()

/datum/macrogame_gamemode/proc/force_rulesets()
	for(var/datum/dynamic_ruleset/found_ruleset in rulesets_to_force)
		switch(found_ruleset.ruletype)
			if(ROUNDSTART_RULESET)
				if(SSticker.HasRoundStarted()) // Round already started due to some flaky shit; qdel this gamemode, pretend nothing happened
					qdel(src)
					return
				GLOB.dynamic_forced_rulesets[type2parent(found_ruleset)] = RULESET_FORCE_ENABLED
				var/roundstart_rules = list()
				found_ruleset = new
				roundstart_rules[found_ruleset.name] = found_ruleset
				GLOB.dynamic_forced_roundstart_ruleset += roundstart_rules[found_ruleset.name]
			if(MIDROUND_RULESET)
				SSdynamic.picking_specific_rule(found_ruleset, forced = TRUE, ignore_cost = TRUE)

// Can we earlycall the emergency shuttle? Override to block based on gamemode conditions. Do NOT call parent; as it'll automatically return TRUE.
/datum/macrogame_gamemode/proc/can_earlycall()
	return TRUE

// Any effects we want to do to the communications console when the shuttle is called? Override.
/datum/macrogame_gamemode/proc/earlycall_effects(obj/machinery/computer/communications/our_console)
	return
