/// LOOC Module
GLOBAL_VAR_INIT(looc_allowed, TRUE)

/// Whether or not we log game logs to the SQL database. Requires the SQL database to function, as well as our Skyrat-only table, `game_log`.
/datum/config_entry/flag/sql_game_log
	protection = CONFIG_ENTRY_LOCKED

/// Whether or not we log game logs to files on the server when we're already logging them on the server, if SQL_GAME_LOG is enabled.
/datum/config_entry/flag/file_game_log
	protection = CONFIG_ENTRY_LOCKED

/// The minimum amount of entries there should be in the list of game logs for a mass query to be sent to the database.
/// Depends on SQL_GAME_LOG being enabled, doesn't mean anything otherwise.
/// Setting this to a value that's too low risks to severely affect perceptible performance, due to a high amount of
/// sleeps being involved with running queries.
/datum/config_entry/number/sql_game_log_min_bundle_size
	default = 100
	min_val = 1

/// Upper value for random events at highpop.
/datum/config_entry/number/event_frequency_upper
	default = 14 MINUTES
/// Lower value for random events at highpop.
/datum/config_entry/number/event_frequency_lower
	default = 7 MINUTES

/// Length of time before the first autotransfer vote is called (deciseconds, default 2 hours)
/// Set to 0 to disable the subsystem altogether.
/datum/config_entry/number/vote_autotransfer_initial
	config_entry_value = 81000
	min_val = 0

///length of time to wait before subsequent autotransfer votes (deciseconds, default 30 minutes)
/datum/config_entry/number/vote_autotransfer_interval
	config_entry_value = 18000
	min_val = 0

/// maximum extensions until the round autoends.
/// Set to 0 to force automatic crew transfer after the 'vote_autotransfer_initial' elapsed.
/// Set to -1 to disable the maximum extensions cap.
/datum/config_entry/number/vote_autotransfer_maximum
	config_entry_value = 4
	min_val = -1

/// Determines if the autotransfer system runs or not.
/datum/config_entry/flag/autotransfer


/// Determines if the transfer vote can be started by anyone or not.
/datum/config_entry/flag/allow_vote_transfer

// EFFIGY API STUFF
/// Use the Effigy API
/datum/config_entry/flag/use_effigy_api
	default = FALSE
/// API configuration
/datum/config_entry/string/effigy_api_url
	abstract_type = /datum/config_entry/string
/// API auth method
/datum/config_entry/string/effigy_api_auth
	abstract_type = /datum/config_entry/string
	default = "Bearer"
/// API key
/datum/config_entry/string/effigy_api_key
	abstract_type = /datum/config_entry/string

/datum/config_entry/number/cryo_min_ssd_time
	config_entry_value = 15

// After u not ded anymore
/datum/config_entry/string/blackoutpolicy
	config_entry_value = "You remember nothing after you've blacked out and you do not remember who killed you. However, you can have recollection of what led up to it."

// Disables the ability to commit suicide
/datum/config_entry/flag/disable_suicide

// Discord config
/datum/config_entry/string/game_alert_role_id
/datum/config_entry/string/role_assign_channel_id


/datum/config_entry/string/alert_green
	default = "Standard security procedures. Security may not have weapons visible, privacy laws are in full effect."

/datum/config_entry/string/alert_blue_upto
	default = "Elevated security alert. Security staff may have weapons visible and are permitted to search crew members with authorization from the Captain or Head of Personnel."

/datum/config_entry/string/alert_blue_downto
	default = "Elevated security alert. Security staff may have weapons visible and are permitted to search crew members with authorization from the Captain or Head of Personnel."

/datum/config_entry/string/alert_yellow_upto
	config_entry_value = "Security incident developing. Random searches of crew are permitted with probable cause. All security personnel are required to disengage personal activities and come to active duty. Non-security personnel are advised to comply with relevant instructions from security staff."

/datum/config_entry/string/alert_yellow_downto
	config_entry_value = "Active security incident in progress. Non-security personnel are advised to comply with relevant instructions from security staff and submit to requested searches."

/datum/config_entry/string/alert_orange_upto
	config_entry_value = "Major security emergency has developed. All random searches are permitted. All security personnel are required to disengage personal activities and come to active duty. Non-security personnel are advised to remain in their departments when possible and comply with security instructions."

/datum/config_entry/string/alert_orange_downto
	config_entry_value = "Major security emergency in progress. All random searches are permitted. Non-security personnel are advised to remain in their departments when possible and comply with security instructions."

/datum/config_entry/string/alert_red_upto
	default = "Immediate serious threat to the station. Security may use all weapons available. All random searches are permitted. Non-security personnel are required to obey all relevant instructions from security staff and remain in their departments unless directed by security."

/datum/config_entry/string/alert_red_downto
	default = "The station's destruction has been averted. However, an immediate serious threat is ongoing. Security may use all weapons available. All random searches are permitted. Non-security personnel are required to obey all relevant instructions from security staff and remain in their departments unless directed by security."

/datum/config_entry/string/alert_delta
	config_entry_value = "Station destruction imminent. All crew are instructed to obey all instructions given by heads of staff or security. Any violations of these orders can be punished by death."

/datum/config_entry/string/alert_pink_upto
	config_entry_value = "Engineering emergency in progress. Non-engineering personnel are required to obey relevant instructions from engineering staff and are recommended to evacuate affected areas. Engineering staff will have expanded card access during this incident."

/datum/config_entry/string/alert_pink_downto
	config_entry_value = "Engineering emergency in progress. Non-engineering personnel are required to obey relevant instructions from engineering staff and are recommended to evacuate affected areas. Engineering staff will have expanded card access during this incident."

/datum/config_entry/string/alert_white_upto
	config_entry_value = "Medical emergency in progress. Non-medical personnel are required to obey all relevant instructions from medical staff. All crew are advised to minimize unecessary contact when possible and proceed to medbay for vaccination when advised."

/datum/config_entry/string/alert_white_downto
	config_entry_value = "Medical emergency in progress. Non-medical personnel are required to obey all relevant instructions from medical staff. All crew are advised to minimize unecessary contact when possible and proceed to medbay for vaccination when advised."
