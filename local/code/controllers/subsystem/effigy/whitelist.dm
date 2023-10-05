/datum/tgs_chat_command/effigy_whitelist
	name = "whitelist"
	help_text = "whitelist <ckey> <effigy_id>"
	admin_only = TRUE

/client/proc/effigy_whitelist(player_key, player_effigy_id)
	set category = "Admin"
	set name = "Whitelist Player"
	set desc = "Link an Effigy account to a ckey and add to whitelist"

	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, span_adminnotice("The Database is not enabled!"))
		return

	var/input_key = tgui_input_text(src, "What is their ckey?", "Someone wants to play here, apparently.")
	if(isnull(input_key))
		return

	var/input_efid = tgui_input_number(src, "What is their Effigy ID?", "Someone wants to play here, apparently.", max_value = 99999999, min_value = 1, default = 0)
	if(isnull(input_efid) || input_efid == 0)
		return

	log_admin("[ckey(usr)] is attempting to add ckey [input_key] with effigy_id [input_efid] to the Effigy whitelist.")
	effigy_player_insert(input_key, input_efid)

/proc/effigy_player_insert(input_key, input_efid)
	if(!CONFIG_GET(flag/sql_enabled))
		message_admins(span_adminnotice("Attempted to add a player to Effigy whitelist, but the Database is not enabled!"))
		log_effigy_api("Attempted to add a player to Effigy whitelist, but the Database is not enabled!")
		return FALSE

	if(isnull(input_key))
		message_admins(span_adminnotice("Attempted to add a player to Effigy whitelist, but no ckey provided!"))
		log_effigy_api("Attempted to add a player to Effigy whitelist, but no ckey provided!")
		return FALSE

	if(isnull(input_efid))
		message_admins(span_adminnotice("Attempted to add a player to Effigy whitelist, but no effigy_id provided!"))
		log_effigy_api("Attempted to add a player to Effigy whitelist, but no effigy_id provided!")
		return FALSE

	var/ckey_to_match = ckey(input_key)
	var/requested_link = 0
	if(isnull(ckey_to_match))
		message_admins(span_notice("Invalid ckey [ckey_to_match] provided."))
		log_effigy_api("Invalid ckey [ckey_to_match] provided.")
		return FALSE

	var/datum/db_query/query_add_player = SSdbcore.NewQuery({"
		INSERT INTO [format_table_name("player")] (`ckey`, `effigy_id`, `firstseen`, `firstseen_round_id`, `lastseen`, `lastseen_round_id`, `ip`, `computerid`, `lastadminrank`)
		VALUES (:ckey, :effigy_id, Now(), :round_id, Now(), :round_id, "0", "0", "Player")
	"}, list("ckey" = ckey_to_match, "effigy_id" = input_efid, "round_id" = GLOB.round_id || null))
	if(!query_add_player.Execute())
		qdel(query_add_player)
		message_admins(span_adminnotice("Add player [ckey_to_match] to DB whitelist failed!"))
		log_effigy_api("Add player [ckey_to_match] to DB whitelist failed!")
		return
	qdel(query_add_player)

	message_admins(span_info("Add player [ckey_to_match] to DB complete! Verifying link..."))
	log_effigy_api("Add player [ckey_to_match] to DB complete!")
	requested_link = SSeffigy.ckey_to_effigy_id(ckey_to_match)
	if(!requested_link)
		message_admins(span_notice("Could not find an Effigy ID for ckey [ckey_to_match]!"))
		log_effigy_api("Could not find an Effigy ID for ckey [ckey_to_match]!")
		return FALSE
	else
		message_admins(span_notice("Found Effigy ID [requested_link] for ckey [ckey_to_match]!"))
		log_effigy_api("Could not find an Effigy ID for ckey [ckey_to_match]!")
		return TRUE

/datum/tgs_chat_command/effigy_whitelist/Run(datum/tgs_chat_user/sender, params)
	if(!CONFIG_GET(flag/sql_enabled))
		return "The Database is not enabled!"

	var/list/all_params = splittext(params, " ")
	if(all_params.len < 2)
		return new /datum/tgs_message_content("Requires both a ckey and an effigy_id!")

	var/input_ckey = all_params[1]
	var/input_efid = all_params[2]

	log_admin("[sender.friendly_name] is attempting to add [params] to the Effigy whitelist.")
	message_admins("[sender.friendly_name] is attempting to add [params] to the Effigy whitelist.")
	if(effigy_player_insert(input_ckey, input_efid))
		return new /datum/tgs_message_content("[params] has been added to the Effigy whitelist.")
	else
		return new /datum/tgs_message_content("ERROR: [params] was not added to the Effigy whitelist. Check logs for more info.")
