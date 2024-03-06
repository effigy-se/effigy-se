/// LOOC Module
GLOBAL_VAR_INIT(looc_allowed, TRUE)

/// Upper value for random events at highpop.
/datum/config_entry/number/event_frequency_upper
	default = 14 MINUTES
/// Lower value for random events at highpop.
/datum/config_entry/number/event_frequency_lower
	default = 7 MINUTES

/// Length of time before the first autotransfer vote is called (deciseconds, default 2 hours)
/// Set to 0 to disable the subsystem altogether.
/datum/config_entry/number/vote_autotransfer_initial
	default = 81000
	min_val = 0

///length of time to wait before subsequent autotransfer votes (deciseconds, default 30 minutes)
/datum/config_entry/number/vote_autotransfer_interval
	default = 18000
	min_val = 0

/// maximum extensions until the round autoends.
/// Set to 0 to force automatic crew transfer after the 'vote_autotransfer_initial' elapsed.
/// Set to -1 to disable the maximum extensions cap.
/datum/config_entry/number/vote_autotransfer_maximum
	default = 4
	min_val = -1

/// Determines if the autotransfer system runs or not.
/datum/config_entry/flag/autotransfer


/// Determines if the transfer vote can be started by anyone or not.
/datum/config_entry/flag/allow_vote_transfer

/// File where fluff status messages are stored
/datum/config_entry/string/fluff_status_file

// EFFIGY API STUFF
/// Enable API features specific to Effigy Live. Disable for downstreams, self-hosted, development etc.
/datum/config_entry/flag/effigy_live_revision
	default = FALSE

/// Use the Effigy API
/datum/config_entry/flag/use_effigy_api
	default = FALSE

/// API configuration
/datum/config_entry/string/effigy_api_url
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/// API auth method
/datum/config_entry/string/effigy_api_auth
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN
	default = "Bearer"

/// API key
/datum/config_entry/string/effigy_api_key
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/// New account registration URL
/datum/config_entry/string/account_registration_url
	protection = CONFIG_ENTRY_LOCKED | CONFIG_ENTRY_HIDDEN

/// Lobby music track ID
/datum/config_entry/string/pregame_lobby_track

/// Lobby music track duration
/datum/config_entry/number/pregame_lobby_duration
	default = -1

/datum/config_entry/number/cryo_min_ssd_time
	default = 15

// After u not ded anymore
/datum/config_entry/string/blackoutpolicy
	default = "You remember nothing after you've blacked out and you do not remember who killed you. However, you can have recollection of what led up to it."

// Disables the ability to commit suicide
/datum/config_entry/flag/disable_suicide

// Discord config
/datum/config_entry/string/game_notify_role_id
/datum/config_entry/string/channel_role_assignment
/datum/config_entry/string/channel_social_new_game
/datum/config_entry/string/channel_social_end_game

/datum/config_entry/flag/all_lights_after_init
	default = FALSE

/datum/config_entry/string/alert_green
	default = "Standard security procedures. Security may not have weapons visible, privacy laws are in full effect."

/datum/config_entry/string/alert_blue_upto
	default = "Elevated security alert. Security staff may have weapons visible and are permitted to search crew members with authorization from the Captain or Head of Personnel."

/datum/config_entry/string/alert_blue_downto
	default = "Elevated security alert. Security staff may have weapons visible and are permitted to search crew members with authorization from the Captain or Head of Personnel."

/datum/config_entry/string/alert_amber_upto
	default = "Security incident developing. Random searches of crew are permitted with probable cause. All security personnel are required to disengage personal activities and come to active duty. Non-security personnel are advised to comply with relevant instructions from security staff."

/datum/config_entry/string/alert_amber_downto
	default = "Active security incident in progress. Non-security personnel are advised to comply with relevant instructions from security staff and submit to requested searches."

/datum/config_entry/string/alert_red_upto
	default = "Immediate serious threat to the station. Security may use all weapons available. All random searches are permitted. Non-security personnel are required to obey all relevant instructions from security staff."

/datum/config_entry/string/alert_red_downto
	default = "The station's destruction has been averted. However, an immediate serious threat is ongoing. Security may use all weapons available. All random searches are permitted. Non-security personnel are required to obey all relevant instructions from security staff."

/datum/config_entry/string/alert_delta
	default = "Station destruction imminent. All crew are instructed to obey all instructions given by heads of staff or security. Any violations of these orders can be punished by death."

/datum/config_entry/string/alert_orange_upto
	default = "Engineering emergency in progress. Non-engineering personnel are required to obey relevant instructions from engineering staff and are recommended to evacuate affected areas. Engineering staff will have expanded station access during this incident."

/datum/config_entry/string/alert_orange_downto
	default = "Engineering emergency in progress. Non-engineering personnel are required to obey relevant instructions from engineering staff and are recommended to evacuate affected areas. Engineering staff will have expanded station access during this incident."

/datum/config_entry/string/alert_violet_upto
	default = "Medical emergency in progress. Non-medical personnel are required to obey all relevant instructions from medical staff. All crew are advised to minimize unecessary contact when possible and proceed to medbay for vaccination when advised."

/datum/config_entry/string/alert_violet_downto
	default = "Medical emergency in progress. Non-medical personnel are required to obey all relevant instructions from medical staff. All crew are advised to minimize unecessary contact when possible and proceed to medbay for vaccination when advised."

/datum/config_entry/number/jungle_budget
	default = 2
	integer = FALSE
	min_val = 0

// Please note the intended jungle caves budget will be ~8 depending on how many ruins there are - this is to avoid issues atm.
/datum/config_entry/number/jungle_cave_budget
	default = 2
	integer = FALSE
	min_val = 0

/datum/config_entry/number/ocean_budget
	default = 6
	integer = FALSE
	min_val = 0

// Please note the intended jungle caves budget will be ~8 depending on how many ruins there are - this is to avoid issues atm.
/datum/config_entry/number/trench_budget
	default = 6
	integer = FALSE
	min_val = 0
