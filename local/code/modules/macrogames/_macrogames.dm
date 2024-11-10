SUBSYSTEM_DEF(macrogames)
	name = "Macrogames"
	flags = SS_NO_FIRE // SHOG NOTE: This might change in future; if we want gamemodes to process on this subsystem.
	/// All currently running gamemodes. Overwritten by should_perpetually_run at roundend if should_perpetually_run is on.
	var/list/running_gamemodes = list()
	/// All gamemodes queued for the next round. Representative of the json.
	var/list/queued_gamemodes = list()
	/// Are we allowing players to vote for gamemodes?
	var/can_players_vote = FALSE
	/// Should we run our current gamemode in perpetuity?
	var/should_perpetually_run = FALSE

/datum/controller/subsystem/macrogames/Initialize()
	if (fexists(QUEUED_GAMEMODES_FILE))
		var/queued_gamemodes_contents = file2text(QUEUED_GAMEMODES_FILE)
		fdel(QUEUED_GAMEMODES_FILE)

		var/list/queued_gamemodes_text_paths = json_decode(queued_gamemodes_contents)
		queued_gamemodes_text_paths = SANITIZE_LIST(queued_gamemodes_contents)

		for (var/gamemode_text_path in queued_gamemodes_text_paths)
			var/found_gamemode_path = text2path(gamemode_text_path)
			if (!ispath(found_gamemode_path, /datum/macrogame_gamemode) || found_gamemode_path == /datum/macrogame_gamemode)
				var/message = "Invalid gamemode path path [found_gamemode_path] was requested in the queued gamemodes!"
				log_game(message)
				message_admins(message)
				continue
			running_gamemodes += new found_gamemode_path

	return SS_INIT_SUCCESS
