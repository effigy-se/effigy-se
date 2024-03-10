/// Log to dynamic and message admins
/datum/controller/subsystem/dynamic/proc/log_dynamic_and_announce(text)
	// message_admins("DYNAMIC: [text]") // EffigyEdit Change - Dynamic Logging
	log_dynamic("[text]")

/// Logging for dynamic procs
/proc/log_dynamic(text, list/data)
	message_admins("DYNAMIC: [text]") // EffigyEdit Add - Dynamic Logging
	logger.Log(LOG_CATEGORY_DYNAMIC, text, data)
