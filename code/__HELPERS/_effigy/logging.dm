/// This logs subtler emotes in game.txt if the conflig flag in effigy_config.txt is true.
/proc/log_subtle(text, list/data)
	logger.Log(LOG_CATEGORY_EMOTE_SUBTLE, text, data)

/proc/log_effigy_api(text, list/data, notify_admins = FALSE, notify_span = "adminnotice")
	logger.Log(LOG_CATEGORY_EFFIGY_API, text, data)
	if(notify_admins)
		message_admins("<span class='[notify_span]'>[text]</span>")

GLOBAL_VAR(character_creation_log)
GLOBAL_PROTECT(character_creation_log)

/// This logs character creation if the conflig flag in effigy_config.txt is true.
/proc/log_creator(text, list/data)
	logger.Log(LOG_CATEGORY_DEBUG_CHARACTER_CREATOR, text, data)
