/// This logs subtler emotes in game.txt if the conflig flag in effigy_config.txt is true.
/proc/log_subtler(text)
	if (CONFIG_GET(flag/log_subtler))
		WRITE_LOG(GLOB.world_game_log, "SUBTLER EMOTE: [text]")

GLOBAL_VAR(character_creation_log)
GLOBAL_PROTECT(character_creation_log)

/// This logs character creation if the conflig flag in effigy_config.txt is true.
/proc/log_creator(text)
	WRITE_LOG(GLOB.character_creation_log, "CREATOR LOG: [text]")
