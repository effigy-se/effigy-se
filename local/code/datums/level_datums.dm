/**
 * White
 *
 * Medical emergency
 */
/datum/security_level/white
	name = "white"
	number_level = SEC_LEVEL_WHITE
	sound = 'sound/misc/notice2.ogg'
	lowering_to_configuration_key = /datum/config_entry/string/alert_white_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_white_upto
	shuttle_call_time_mod = 1

/**
 * Magenta
 *
 * Engineering emergency
 */
/datum/security_level/magenta
	name = "magenta"
	number_level = SEC_LEVEL_MAGENTA
	sound = 'sound/misc/notice2.ogg'
	lowering_to_configuration_key = /datum/config_entry/string/alert_magenta_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_magenta_upto
	shuttle_call_time_mod = 0.75

/**
 * Yellow
 *
 * Securty emergency
 */
/datum/security_level/yellow
	name = "yellow"
	number_level = SEC_LEVEL_YELLOW
	sound = 'sound/misc/notice1.ogg'
	lowering_to_configuration_key = /datum/config_entry/string/alert_yellow_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_yellow_upto
	shuttle_call_time_mod = 0.5

/**
 * Orange
 *
 * Big securty emergency
 */
/datum/security_level/orange
	name = "orange"
	number_level = SEC_LEVEL_ORANGE
	sound = 'sound/misc/notice1.ogg'
	lowering_to_configuration_key = /datum/config_entry/string/alert_orange_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_orange_upto
	shuttle_call_time_mod = 0.5
