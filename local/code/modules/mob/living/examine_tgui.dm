/datum/examine_panel
	/// Mob that the examine panel belongs to.
	var/mob/living/holder
	/// The screen containing the appearance of the mob
	var/atom/movable/screen/map_view/examine_panel_screen/examine_panel_screen


/datum/examine_panel/ui_state(mob/user)
	return GLOB.always_state


/datum/examine_panel/ui_close(mob/user)
	user.client.clear_map(examine_panel_screen.assigned_map)


/atom/movable/screen/map_view/examine_panel_screen
	name = "examine panel screen"


/datum/examine_panel/ui_interact(mob/user, datum/tgui/ui)
	if(!examine_panel_screen)
		examine_panel_screen = new
		examine_panel_screen.name = "screen"
		examine_panel_screen.assigned_map = "examine_panel_[REF(holder)]_map"
		examine_panel_screen.del_on_map_removal = FALSE
		examine_panel_screen.screen_loc = "[examine_panel_screen.assigned_map]:1,1"

	var/mutable_appearance/current_mob_appearance = new(holder)
	current_mob_appearance.setDir(SOUTH)
	current_mob_appearance.transform = matrix() // We reset their rotation, in case they're lying down.

	// In case they're pixel-shifted, we bring 'em back!
	current_mob_appearance.pixel_x = 0
	current_mob_appearance.pixel_y = 0

	examine_panel_screen.cut_overlays()
	examine_panel_screen.add_overlay(current_mob_appearance)

	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		examine_panel_screen.display_to(user)
		user.client.register_map_obj(examine_panel_screen)
		ui = new(user, src, "ExaminePanel")
		ui.open()


/datum/examine_panel/ui_data(mob/user)
	var/list/data = list()

	var/datum/preferences/preferences = holder.client?.prefs

	var/flavor_text
	var/custom_species
	var/custom_species_lore
	var/obscured
	var/obscure_on_examine = preferences.read_preference(/datum/preference/toggle/obscure_on_examine)
	var/ooc_notes = ""
	var/headshot = ""

	//  Handle OOC notes first
	if(preferences && preferences.read_preference(/datum/preference/toggle/master_erp_preferences))
		var/e_prefs = preferences.read_preference(/datum/preference/choiced/erp_status)
		var/e_prefs_mechanical = preferences.read_preference(/datum/preference/choiced/erp_status_mechanics)
		ooc_notes += "ERP: [e_prefs]\n"
		ooc_notes += "ERP Mechanics: [e_prefs_mechanical]\n"
		ooc_notes += "\n"

	// Now we handle silicon and/or human, order doesn't really matter
	// If other variants of mob/living need to be handled at some point, put them here
	if(issilicon(holder))
		flavor_text = preferences.read_preference(/datum/preference/text/silicon_flavor_text)
		custom_species = "Silicon"
		custom_species_lore = "A cyborg unit."
		ooc_notes += preferences.read_preference(/datum/preference/text/ooc_notes)
		headshot += preferences.read_preference(/datum/preference/text/headshot)

	if(ishuman(holder))
		var/mob/living/carbon/human/holder_human = holder
		obscured = (holder_human.wear_mask && (holder_human.wear_mask.flags_inv & HIDEFACE)) && obscure_on_examine || (holder_human.head && (holder_human.head.flags_inv & HIDEFACE) && obscure_on_examine)
		custom_species = obscured ? "Obscured" : holder_human.dna.features["custom_species"]
		flavor_text = obscured ? "Obscured" :  holder_human.dna.features["flavor_text"]
		custom_species_lore = obscured ? "Obscured" : holder_human.dna.features["custom_species_lore"]
		ooc_notes += holder_human.dna.features["ooc_notes"]
		if(!obscured)
			headshot += holder_human.dna.features["headshot"]

	var/name = obscured ? "Unknown" : holder.name

	data["obscured"] = obscured ? TRUE : FALSE
	data["character_name"] = name
	data["assigned_map"] = examine_panel_screen.assigned_map
	data["flavor_text"] = flavor_text
	data["ooc_notes"] = ooc_notes
	data["custom_species"] = custom_species
	data["custom_species_lore"] = custom_species_lore
	data["headshot"] = headshot
	return data

/*
EXTRA EXAMINE MODULE

This is the module for handling items with special examine stats,
like syndicate items having information in their description that
would only be recognisable with someone that had the syndicate trait.
*/

// Give the detective the ability to see this stuff.
/datum/job/detective
	mind_traits = list(TRAIT_DETECTIVE)

/obj/item
	//The special description that is triggered when special_desc_requirements are met. Make sure you set the correct EXAMINE_CHECK!
	var/special_desc = ""

	//The special affiliation type, basically overrides the "Syndicate Affiliation" for SYNDICATE check types. It will show whatever organisation you put here instead of "Syndicate Affiliation"
	var/special_desc_affiliation = ""

	//The requirement setting for special descriptions. See examine_defines.dm for more info.
	var/special_desc_requirement = EXAMINE_CHECK_NONE

	//The ROLE requirement setting if EXAMINE_CHECK_ROLE is set. E.g. ROLE_SYNDICATE. As you can see, it's a list. So when setting it, ensure you do = list(shit1, shit2)
	var/list/special_desc_roles

	//The JOB requirement setting if EXAMINE_CHECK_JOB is set. E.g. JOB_SECURITY_OFFICER. As you can see, it's a list. So when setting it, ensure you do = list(shit1, shit2)
	var/list/special_desc_jobs

	//The FACTION requirement setting if EXAMINE_CHECK_FACTION is set. E.g. "Syndicate". As you can see, it's a list. So when setting it, ensure you do = list(shit1, shit2)
	var/list/special_desc_factions


/obj/item/examine(mob/user)
	. = ..()
	if(special_desc_requirement == EXAMINE_CHECK_NONE && special_desc)
		. += span_notice("This item could be examined further...")

/obj/item/examine_more(mob/user)
	. = ..()
	if(special_desc)
		var/composed_message
		switch(special_desc_requirement)
			//Will always show if set
			if(EXAMINE_CHECK_NONE)
				composed_message = "You note the following: <br>"
				composed_message += special_desc
				. += composed_message
			//Mindshield checks
			if(EXAMINE_CHECK_MINDSHIELD)
				if(HAS_TRAIT(user, TRAIT_MINDSHIELD))
					composed_message = "You note the following because of your <span class='blue'><b>mindshield</b></span>: <br>"
					composed_message += special_desc
					. += composed_message
			//Standard syndicate checks
			if(EXAMINE_CHECK_SYNDICATE)
				if(user.mind)
					var/datum/mind/M = user.mind
					if((M.special_role == ROLE_TRAITOR) || (ROLE_SYNDICATE in user.faction))
						composed_message = "You note the following because of your <span class='red'><b>[special_desc_affiliation ? special_desc_affiliation : "Syndicate Affiliation"]</b></span>: <br>"
						composed_message += special_desc
						. += composed_message
					else if(HAS_TRAIT(M, TRAIT_DETECTIVE))  //Useful detective!
						composed_message = "You note the following because of your brilliant <span class='blue'><b>Detective skills</b></span>: <br>"
						composed_message += special_desc
						. += composed_message
			//As above, but with a toy desc for those looking at it
			if(EXAMINE_CHECK_SYNDICATE_TOY)
				if(user.mind)
					var/datum/mind/M = user.mind
					if((M.special_role == ROLE_TRAITOR) || (ROLE_SYNDICATE in user.faction))
						composed_message = "You note the following because of your <span class='red'><b>[special_desc_affiliation ? special_desc_affiliation : "Syndicate Affiliation"]</b></span>: <br>"
						composed_message += special_desc
						. += composed_message
					else if(HAS_TRAIT(M, TRAIT_DETECTIVE)) //Useful detective!
						composed_message = "You note the following because of your brilliant <span class='blue'><b>detective skills</b></span>: <br>"
						composed_message += special_desc
						. += composed_message
					else
						composed_message = "The popular toy resembling [src] from your local arcade, suitable for children and adults alike."
						. += composed_message
			//Standard role checks
			if(EXAMINE_CHECK_ROLE)
				if(user.mind)
					var/datum/mind/M = user.mind
					for(var/role_i in special_desc_roles)
						if(M.special_role == role_i)
							composed_message = "You note the following because of your <b>[role_i]</b> role: <br>"
							composed_message += special_desc
							. += composed_message
			//Standard job checks
			if(EXAMINE_CHECK_JOB)
				if(ishuman(user))
					var/mob/living/carbon/human/H = user
					for(var/job_i in special_desc_jobs)
						if(H.job == job_i)
							composed_message = "You note the following because of your job as a <b>[job_i]</b>: <br>"
							composed_message += special_desc
							. += composed_message
			//Standard faction checks
			if(EXAMINE_CHECK_FACTION)
				for(var/faction_i in special_desc_factions)
					if(faction_i in user.faction)
						composed_message = "You note the following because of your loyalty to <b>[faction_i]</b>: <br>"
						composed_message += special_desc
						. += composed_message
			//If they are a syndicate contractor or a syndicate
			if(EXAMINE_CHECK_CONTRACTOR)
				var/mob/living/carbon/human/human_user = user

				if(HAS_TRAIT(human_user, TRAIT_DETECTIVE))  //Useful detective!
					composed_message = "You note the following because of your brilliant <span class='blue'><b>Detective skills</b></span>: <br>"
					composed_message += special_desc
					. += composed_message
				else if((human_user.mind.special_role == ROLE_TRAITOR) || (ROLE_SYNDICATE in human_user.faction))
					composed_message = "You note the following because of your [span_red("<b>[special_desc_affiliation ? special_desc_affiliation : "Syndicate Affiliation"]</b>")]: <br>"
					composed_message += special_desc
					. += composed_message

/*
*	EXAMPLES
*/

/obj/item/storage/backpack/duffelbag/syndie
	name = "duffel bag"
	desc = "A large duffel bag for holding extra supplies."
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "This bag is used to store tactical equipment and is manufactured by the syndicate."
