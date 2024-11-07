/// We handle gameplay logic on the datum level rather than on SSMacrogames to allow for modularity
/datum/macrogame_gamemode
	var/name = "Untitled Gamemode"
	var/description = "A bunch of people on a space station wonder why the round isn't working correctly."

	// Should we force any dynamic rulesets?
	var/list/rulesets_to_force = list()
	// What jobs should we allow?
	var/whitelisted_jobs = list()

	// What events should we prevent from running?
	var/blacklisted_events = list()

	// Possible main menu images for this gamemode.
	var/main_menu_images = list()

	// MAPPING STUFF//
	// Does this require dedicated maps for this gamemode? If so; what mapflags does it need?
	var/gamemode_mapflags = list()
	// Do we ONLY run on maps with the apropriate mapflags? (IE: Not compatible with automapper tweaks?)
	var/requires_mapflags = FALSE

	// List of automapper tasks needed for this gamemode on maps that DO NOT have the gamemode mapflags.
	var/automapper_tasks = list()
