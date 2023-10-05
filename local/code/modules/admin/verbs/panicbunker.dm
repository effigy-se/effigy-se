GLOBAL_LIST_EMPTY(bunker_passthrough)

/client/proc/addbunkerbypass(ckeytobypass as text)
	set category = "Admin"
	set name = "Add PB bypass"
	set desc = "Allows a given ckey to connect despite the panic bunker for a given round."
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, span_adminnotice("The Database is not enabled!"))
		return

	GLOB.bunker_passthrough |= ckey(ckeytobypass)
	GLOB.bunker_passthrough[ckey(ckeytobypass)] = world.realtime
	log_admin("[key_name(usr)] has added [ckeytobypass] to the current round's bunker bypass list.")
	message_admins("[key_name_admin(usr)] has added [ckeytobypass] to the current round's bunker bypass list.")

/client/proc/revokebunkerbypass(ckeytobypass as text)
	set category = "Admin"
	set name = "Remove PB bypass"
	set desc = "Revoke's a ckey's permission to bypass the panic bunker for a given round."

	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, span_adminnotice("The Database is not enabled!"))
		return

	GLOB.bunker_passthrough -= ckey(ckeytobypass)
	log_admin("[key_name(usr)] has removed [ckeytobypass] from the current round's bunker bypass list.")
	message_admins("[key_name_admin(usr)] has removed [ckeytobypass] from the current round's bunker bypass list.")
