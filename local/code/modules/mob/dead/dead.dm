/mob/dead/get_status_tab_items()
	. = ..()
	if(SSticker.HasRoundStarted())
		return
	var/time_remaining = SSticker.GetTimeLeft()
	if(time_remaining > 0)
		. += "Game starting in [round(time_remaining/10)]s"
	else if(time_remaining == -10)
		. += "Game start delayed by an administrator"
	else if(SSticker.totalPlayersReady == 0)
		. += "Game will start when players are ready"
	else
		. += pick(
			"Filling Poly's speech buffer",
			"Sending departmental orders",
			"Clearing tram scoreboard",
			"Caffeinating admins",
		)
	. += ""
	. += "Players Ready: [SSticker.totalPlayersReady]"
	if(client.holder)
		. += "Admins Ready: [SSticker.total_admins_ready] / [length(GLOB.admins)]"
