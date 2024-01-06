// This is a global singleton. Keep in mind that all operations should occur on user, not src.
/datum/character_directory

/datum/character_directory/ui_state(mob/user)
	return GLOB.always_state

/datum/character_directory/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "CharacterDirectory", "Character Directory")
		ui.open()

//We want this information to update any time the player updates their preferences, not just when the panel is refreshed
/datum/character_directory/ui_data(mob/user)
	. = ..()
	var/list/data = .

//Collect the user's own preferences for the top of the UI
	if (user?.client?.prefs)
		data["personalVisibility"] = READ_PREFS(user, toggle/show_in_directory)
		data["personalAttraction"] = READ_PREFS(user, choiced/attraction)
		data["personalGender"] = READ_PREFS(user, choiced/display_gender)
		data["personalErpTag"] = READ_PREFS(user, choiced/erp_status)
		data["prefsOnly"] = TRUE

	data["canOrbit"] = isobserver(user)

	return data

/datum/character_directory/ui_static_data(mob/user)
	var/list/data = list()
	var/list/directory_mobs = list()
	//We want the directory to display only alive players, not observers or people in the lobby
	for(var/mob/mob in GLOB.alive_player_list)
		// These are the variables we're trying to display in the directory
		var/name = ""
		var/species = "Ask"
		var/ooc_notes = ""
		var/flavor_text = ""
		var/attraction = "Unset"
		var/gender = "Nonbinary"
		var/erp = "Ask"
		var/character_ad = ""
		var/exploitable = ""
		var/ref = REF(mob)
		//Just in case something we get is not a mob
		if(!mob)
			continue

		//Different approach for humans and silicons
		if(ishuman(mob))
			var/mob/living/carbon/human/human = mob
			//If someone is obscured without flavor text visible, we don't want them on the Directory.
			if((human.wear_mask && (human.wear_mask.flags_inv & HIDEFACE) && READ_PREFS(human, toggle/obscure_on_examine)) || (human.head && (human.head.flags_inv & HIDEFACE) && READ_PREFS(human, toggle/obscure_on_examine)) || (HAS_TRAIT(human, TRAIT_UNKNOWN)))
				continue
			//Display custom species, otherwise show base species instead
			species = (READ_PREFS(human, text/custom_species))
			if(species == "Unset")
				species = "[human.dna.species.name]"
			//Load standard flavor text preference
			flavor_text = READ_PREFS(human, text/flavor_text)
		else if(issilicon(mob))
			var/mob/living/silicon/silicon = mob
			//If the target is a silicon, we want it to show its brain as its species
			species = READ_PREFS(silicon, choiced/brain_type)
			//Load silicon flavor text in place of normal flavor text
			flavor_text = READ_PREFS(silicon, text/silicon_flavor_text)
		//Don't show if they are not a human or a silicon
		else
			continue
		//List of all the shown ERP preferences in the Directory. If there is none, return "Unset"
		attraction = READ_PREFS(mob, choiced/attraction)
		gender = READ_PREFS(mob, choiced/display_gender)
		erp = READ_PREFS(mob, choiced/erp_status)
		character_ad = READ_PREFS(mob, text/character_ad)
		ooc_notes = READ_PREFS(mob, text/ooc_notes)
		//If the user is an antagonist or Observer, we want them to be able to see exploitables in the Directory.
		if(user.mind?.has_antag_datum(/datum/antagonist) || isobserver(user))
			if(exploitable == EXPLOITABLE_DEFAULT_TEXT)
				exploitable = "Unset"
			else exploitable = READ_PREFS(mob, text/exploitable)
		else exploitable = "Obscured"
		//And finally, we want to get the mob's name, taking into account disguised names.
		name = mob.real_name ? mob.name : mob.real_name

		directory_mobs.Add(list(list(
			"name" = name,
			"species" = species,
			"ooc_notes" = ooc_notes,
			"attraction" = attraction,
			"gender" = gender,
			"erp" = erp,
			"exploitable" = exploitable,
			"character_ad" = character_ad,
			"flavor_text" = flavor_text,
			"ref" = ref
		)))

	data["directory"] = directory_mobs

	return data

/datum/character_directory/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	if(.)
		return

	var/mob/user = usr
	if(!user)
		return

	switch(action)
		if("refresh")
			// This is primarily to stop malicious users from trying to lag the server by spamming this verb
			if(!COOLDOWN_FINISHED(user.client, char_directory_cooldown))
				to_chat(user, span_warning("Directory refresh on cooldown."))
				return
			COOLDOWN_START(user.client, char_directory_cooldown, 10 SECONDS)
			update_static_data(user, ui)
			return TRUE
		if("orbit")
			var/ref = params["ref"]
			var/mob/dead/observer/ghost = user
			var/atom/movable/poi = (locate(ref) in GLOB.mob_list)
			if(isnull(poi))
				return TRUE
			ghost.ManualFollow(poi)
			ghost.reset_perspective(null)
			return TRUE
		if("view")
			var/ref = params["ref"]
			var/datum/examine_panel/panel
			var/mob/living/target = (locate(ref) in GLOB.mob_list)
			if(issilicon(target))
				var/mob/living/silicon/typed_target = target
				panel = typed_target.examine_panel
				panel.holder = typed_target
			else
				var/mob/living/carbon/human/typed_target = target
				panel = typed_target.tgui
				panel.holder = typed_target
			panel.ui_interact(user)
