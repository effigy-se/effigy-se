// This is a global singleton. Keep in mind that all operations should occur on user, not src.
/datum/effigy_popup

/datum/effigy_popup/ui_state(mob/user)
	return GLOB.always_state

/datum/effigy_popup/account_restricted/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "EffigyAccountRestricted", "Not Authorized \[2F173/2]")
		ui.open()

/datum/effigy_popup/account_restricted/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	if(.)
		return

	var/mob/user = usr
	if(!user)
		return

	switch(action)
		if("registration")
			var/register_url = CONFIG_GET(string/account_registration_url)
			if(isnull(register_url))
				return
			var/mob/window_target = ui.user
			window_target << link(register_url)
