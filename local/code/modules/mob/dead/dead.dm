/mob/dead/get_status_tab_items()
	. = ..()
	if(SSticker.HasRoundStarted())
		return
	var/time_remaining = SSticker.GetTimeLeft()
	if(time_remaining > 0)
		. += "Game starting in [round(time_remaining/10)]s"
	else if(time_remaining == -10)
		. += "Game start delayed by an administrator"
	else if(SSticker.launch_queued && !SSticker.totalPlayersReady)
		. += "Game will start when players are ready"
	else
		. += pick(SSticker.fluff_status)
	. += ""
	. += "Players Ready: [SSticker.totalPlayersReady]"
	if(client.holder)
		. += "Admins Ready: [SSticker.total_admins_ready] / [length(GLOB.admins)]"

	// Adds the manifest preview panel to the end of the Statpanel.
	if(CONFIG_GET(flag/show_manifest_preview))
		. += get_manifest_preview()

/mob/dead/proc/get_manifest_preview()
	var/list/player_ready_data = list()
	var/list/players = list()

	// This fills the readied players list that the manifest preview panel uses.
	for(var/mob/dead/new_player/player as anything in GLOB.new_player_list)
		if(player.ready == PLAYER_READY_TO_PLAY)
			players[player.key] = player

		sortTim(players, GLOBAL_PROC_REF(cmp_text_asc))

	for(var/ckey in players)
		var/mob/dead/new_player/player = players[ckey]
		var/datum/preferences/prefs = player.client?.prefs
		// If a player does not have preferences (for some reason) or they don't want to be shown on the panel, continue
		if(!prefs || !prefs.read_preference(/datum/preference/toggle/manifest_preview))
			continue

		var/display = null
		var/datum/job/priority_job = prefs.get_highest_priority_job()

		// If, for whatever reason, the person readied doesn't have a selected job, they shouldn't be displayed
		if(!priority_job)
			continue

		// If the job the player is selecting has a special name, that name should be displayed in the menu, otherwise it should use the normal name
		switch(priority_job.title)
			if(JOB_AI)
				display = prefs.read_preference(/datum/preference/name/ai)
			if(JOB_CLOWN)
				display = prefs.read_preference(/datum/preference/name/clown)
			if(JOB_CYBORG)
				display = prefs.read_preference(/datum/preference/name/cyborg)
			if(JOB_MIME)
				display = prefs.read_preference(/datum/preference/name/mime)
			else
				display = prefs.read_preference(/datum/preference/name/real_name)

		var/title = priority_job.title
		// If the player is ready to play, we want to add them to the statpanel
		if(player.ready == PLAYER_READY_TO_PLAY)
			//If our player is a member of Command or a Silicon, we want to sort them to the top of the list. Otherwise, just add them to the end of the list.
			if(priority_job.departments_bitflags & (DEPARTMENT_BITFLAG_COMMAND | DEPARTMENT_BITFLAG_SILICON))
				player_ready_data.Insert(1, "* [title]: [display]")
			else
				player_ready_data += "* [title]: [display]"

	//The title line for the job estimation panel, obviously needs to be at the top
	if(length(player_ready_data))
		player_ready_data.Insert(1, "Manifest Preview:")
		player_ready_data.Insert(1, "")
	return player_ready_data
