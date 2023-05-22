/// This logs subtler emotes in game.txt if the conflig flag in effigy_config.txt is true.
/proc/log_subtle(text, list/data)
	logger.Log(LOG_CATEGORY_GAME_SUBTLE, text, data)

/proc/log_subtler(text, list/data)
	logger.Log(LOG_CATEGORY_GAME_SUBTLER, text, data)

GLOBAL_VAR(character_creation_log)
GLOBAL_PROTECT(character_creation_log)

/// This logs character creation if the conflig flag in effigy_config.txt is true.
/proc/log_creator(text, list/data)
	logger.Log(LOG_CATEGORY_DEBUG_CHARACTER_CREATOR, text, data)
