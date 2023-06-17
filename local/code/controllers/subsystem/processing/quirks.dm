/datum/controller/subsystem/processing/quirks/proc/setup_quirks_se(datum/quirk/quirk_type)
	if(initial(quirk_type.erp_quirk) && CONFIG_GET(flag/disable_erp_preferences))
		return TRUE

	// Hidden quirks aren't visible to TGUI or the player
	if (initial(quirk_type.hidden_quirk))
		return TRUE

	return FALSE

/datum/controller/subsystem/processing/quirks/proc/filter_augments_se(balance, list/augments)
	for(var/key in augments)
		var/datum/augment_item/aug = GLOB.augment_items[augments[key]]
		balance += aug.cost

	return balance
