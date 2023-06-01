/world/proc/update_status()

	var/features
	var/new_status = "<a href=\"https://socialdistrict.effigy.se\"><b>Effigy Station</a>] &#8212; [GLOB.tagline]</b> (<a href=\"https://socialdistrict.effigy.se\">Discord/Site</a>)<br/>\[18+] <b>\[Anthro Mixed RP/Action]</b> \[Whitelist]<br/>"
	var/round_real_time = REALTIMEOFDAY - SSticker.round_start_real_time

	if(SSmapping.config)
		features += "\[/tg/ Downstream] \[[SSmapping.config.map_name] - [SSsecurity_level.get_current_level_as_text()] alert [SSticker.HasRoundStarted() ? "- [time2text(round_real_time, "hh:mm", 0)]" : ""]"

	if (features)
		new_status += features

	status = new_status
