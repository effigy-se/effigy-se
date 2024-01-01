/**
 * Enables an admin to upload a new titlescreen image.
 */
/client/proc/admin_change_title_screen()
	set category = "Admin.Fun"
	set name = "Title Screen: Change"

	if(!check_rights(R_FUN))
		return

	log_admin("[key_name(usr)] is changing the title screen.")
	message_admins("[key_name_admin(usr)] is changing the title screen.")

	switch(alert(usr, "Please select a new title screen.", "Title Screen", "Change", "Reset", "Cancel"))
		if("Change")
			var/file = input(usr) as icon|null
			if(!file)
				return
			SStitle.change_title_screen(file)
		if("Reset")
			SStitle.change_title_screen()
		if("Cancel")
			return

/**
 * Sets a titlescreen notice, a big red text on the main screen.
 */
/client/proc/change_title_screen_notice()
	set category = "Admin.Fun"
	set name = "Title Screen: Set Notice"

	if(!check_rights(R_FUN))
		return

	var/new_notice = input(usr, "Please input a notice to be displayed on the title screen:", "Titlescreen Notice") as text|null
	SStitle.set_notice(new_notice)
	if(!new_notice)
		return

	log_admin("[key_name(usr)] is setting the title screen notice: [new_notice]")
	message_admins("[key_name_admin(usr)] is setting the title screen notice [new_notice]")

	for(var/mob/dead/new_player/new_player in GLOB.new_player_list)
		to_chat(new_player, span_boldannounce("Admin Notice: [new_notice]"))

/**
 * Reloads the titlescreen if it is bugged for someone.
 */
/client/verb/fix_title_screen()
	set name = "Fix Lobby Screen"
	set desc = "Lobbyscreen broke? Press this."
	set category = "OOC"

	if(istype(mob, /mob/dead/new_player))
		var/mob/dead/new_player/new_player = mob
		new_player.show_title_screen()
	else
		winset(src, "title_browser", "is-disabled=true;is-visible=false")
		winset(src, "status_bar", "is-visible=true")
