/proc/discord_new_game_alert()
	send2chat(new /datum/tgs_message_content("<@&[CONFIG_GET(string/game_notify_role_id)]> Round **[GLOB.round_hex]** starting on [SSmapping.config.map_name]! \nTo subscribe to game related pings, go to <#[CONFIG_GET(string/channel_role_assignment)]> and pick your roles."), CONFIG_GET(string/channel_announce_new_game))
	send2chat(new /datum/tgs_message_content("[GLOB.station_name] shift starting on [SSmapping.config.map_name]!"), CONFIG_GET(string/channel_social_new_game))

/proc/discord_end_game_alert()
	send2chat("<@&[CONFIG_GET(string/game_notify_role_id)]> [SSticker.send_news_report()]", CONFIG_GET(string/channel_announce_end_game))
	send2chat(SSticker.send_news_report(), CONFIG_GET(string/channel_social_end_game))
