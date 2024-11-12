// I apologize in advance. But. I couldn't manage TGUI; which means a lot of the customization I wanted just.. fucking. Isn't. augh
ADMIN_VERB(macrogames, R_FUN, "Macrogames Setup", "Set up; add; and remove any macrogames.", ADMIN_CATEGORY_FUN)
	/// First; offer to delete any gamemodes that exist already.
	if(SSmacrogames.running_gamemodes || SSmacrogames.queued_gamemodes)
		for(var/datum/macrogame_gamemode/found_gamemode in (SSmacrogames.running_gamemodes || SSmacrogames.queued_gamemodes))
			var/delete_prompt = tgui_alert(user, "Remove [found_gamemode.name] from Queued / Running gamemodes?", "Remove [found_gamemode.name]", list("Yes", "No", "Cancel"))
			switch(delete_prompt)
				if("Yes")
					qdel(found_gamemode)
				if("No")
					continue
				if("Cancel")
					break
	/// Next; set up and create a new gamemode.
	var/datum/macrogame_gamemode/choice = tgui_input_list(
		user,
		"Chose a macrogame gamemode to inject into the queue or the next round.",
		"Choose Gamemode",
		sort_list(subtypesof(/datum/macrogame_gamemode), GLOBAL_PROC_REF(cmp_typepaths_asc)),
	)
	if(!choice || !ispath(choice, /datum/macrogame_gamemode))
		return
	choice = new
