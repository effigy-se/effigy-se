/// We handle gameplay logic on the datum level rather than on SSMacrogames to allow for modularity
/datum/macrogame_gamemode
	var/name = "Untitled Gamemode"
	var/description = "A bunch of people on a space station wonder why the round isn't working correctly."

	/// Can we run this gamemode midround?
	var/can_be_run_midround = TRUE

	/// Should we process this gamemode?
	var/should_process = FALSE

	/// Should we force any dynamic rulesets?
	var/list/rulesets_to_force = list()

	/// What events should we prevent from running?
	var/blacklisted_events = list()

	/// JOB STUFF ///
	/// What jobs should we allow?
	var/whitelisted_jobs = list()

	/// TITLE STUFF ///
	/// The Splash HTML we want to use for this gamemode, if any. NULL Uses codebase default.
	var/replacement_splash_html
	/// Possible main menu images for this gamemode.
	var/main_menu_images = list()


	/// MAPPING STUFF ///
	/// Do we ONLY run on maps with the apropriate mapflags?
	var/requires_mapflags = FALSE

/datum/macrogame_gamemode/New()
	if(do_can_run_checks())
		SSmacrogames.running_gamemodes += src
		do_gamemode_setup()
	else
		SSmacrogames.queued_gamemodes += src

/// Override to replace the checks needed to see if you can run any given gamemode this round.
/datum/macrogame_gamemode/proc/do_can_run_checks()
	if((!SSticker.HasRoundStarted() || can_be_run_midround) && (!requires_mapflags || (name in SSmapping.config?.gamemode_mapflags)))
		return TRUE
	return FALSE

/// The 'master' gamemode logic runthrough; to keep things relatively simple.
/datum/macrogame_gamemode/proc/do_gamemode_setup()
	handle_main_menu()
	if(blacklisted_events)
		blacklist_events()
	if(whitelisted_jobs)
		whitelist_jobs()
	if(rulesets_to_force)
		force_rulesets()

/// If main_menu_images is set; picks an image and changes the title screen to show it.
/// If replacement_splash_html is set; changes the title screen HTML to the splash txt.
/// IT IS HIGHLY RECCOMENDED YOU VET WHO CAN UPLOAD TO; OR EDIT; YOUR CONFIG FOLDER. This was an attack vector even prior to SSmacrogames.
/// Override for more specific edits.
/datum/macrogame_gamemode/proc/handle_main_menu()
	if(initial(replacement_splash_html))
		if(fexists("[global.config.directory]/[initial(replacement_splash_html)].txt"))
			SStitle.title_html = file2text("[global.config.directory]/[initial(replacement_splash_html)].txt")
	if(main_menu_images)
		SStitle.change_title_screen(pick(main_menu_images))

/// Removes events we don't want to run from SSevents. Does not clean up unwanted events that have already fired.
/datum/macrogame_gamemode/proc/blacklist_events()
	for(var/datum/round_event_control/possible_event in blacklisted_events)
		if(possible_event in SSevents.control)
			SSevents.control -= possible_event

/// Restricts jobs to only the ones we want.
/datum/macrogame_gamemode/proc/whitelist_jobs()
	SSmacrogames.joinable_occupations_copy = SSjob.joinable_occupations.Copy()
	for(var/datum/job/found_job in SSjob.joinable_occupations)
		if(found_job in whitelisted_jobs)
			continue
		SSjob.joinable_occupations -= found_job

/// FORCE THOSE RULESETS...
