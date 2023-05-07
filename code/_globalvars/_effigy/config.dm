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
