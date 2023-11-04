/datum/controller/subsystem/ticker
	/// Did we broadcast at players to hurry up?
	var/delay_notified = FALSE
	/// UTC time of round start
	var/round_start_real_time = 0

/proc/discord_new_game_alert()
	send2chat(new /datum/tgs_message_content("<@&[CONFIG_GET(string/game_notify_role_id)]> Round **[GLOB.round_hex]** starting on [SSmapping.config.map_name]! \nTo subscribe to game related pings, go to <#[CONFIG_GET(string/channel_role_assignment)]> and pick your roles."), CONFIG_GET(string/channel_announce_new_game))
	send2chat(new /datum/tgs_message_content("[GLOB.station_name] shift starting on [SSmapping.config.map_name]!"), CONFIG_GET(string/channel_social_new_game))

/proc/discord_end_game_alert(message)
	send2chat("<@&[CONFIG_GET(string/game_notify_role_id)]> [message]", CONFIG_GET(string/channel_announce_end_game))
	send2chat(message, CONFIG_GET(string/channel_social_end_game))
