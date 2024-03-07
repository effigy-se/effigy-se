/**
 * Violet
 *
 * Medical emergency
 */
/datum/security_level/violet
	name = "violet"
	announcement_color = "purple"
	number_level = SEC_LEVEL_VIOLET
	sound = 'sound/misc/notice2.ogg'
	lowering_to_configuration_key = /datum/config_entry/string/alert_violet_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_violet_upto
	shuttle_call_time_mod = 0.75

/**
 * Orange
 *
 * Engineering emergency
 */
/datum/security_level/orange
	name = "orange"
	announcement_color = "orange"
	number_level = SEC_LEVEL_ORANGE
	sound = 'sound/misc/notice2.ogg'
	lowering_to_configuration_key = /datum/config_entry/string/alert_orange_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_orange_upto
	shuttle_call_time_mod = 0.75

/**
 * Amber
 *
 * Securty emergency
 */
/datum/security_level/amber
	name = "amber"
	announcement_color = "yellow"
	number_level = SEC_LEVEL_AMBER
	sound = 'sound/misc/notice1.ogg'
	lowering_to_configuration_key = /datum/config_entry/string/alert_amber_downto
	elevating_to_configuration_key = /datum/config_entry/string/alert_amber_upto
	shuttle_call_time_mod = 0.5

/datum/security_level/delta
	announcement_color = "default"
