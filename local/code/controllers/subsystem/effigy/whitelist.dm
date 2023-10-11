/client/proc/effigy_whitelist()
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
		log_effigy_api("Attempted to add a player to Effigy whitelist, but the database is not enabled!", notify_admins = TRUE)
		return FALSE

	if(isnull(input_key))
		log_effigy_api("Attempted to add a player to Effigy whitelist, but no ckey provided!", notify_admins = TRUE)
		return FALSE

	if(isnull(input_efid))
		log_effigy_api("Attempted to add a player to Effigy whitelist, but no effigy_id provided!", notify_admins = TRUE)
		return FALSE

	var/ckey_to_match = ckey(input_key)
	var/requested_link = 0
	if(isnull(ckey_to_match))
		log_effigy_api("Invalid ckey [ckey_to_match] provided.", notify_admins = TRUE)
		return FALSE

	var/datum/db_query/query_add_player = SSdbcore.NewQuery({"
		INSERT INTO [format_table_name("player")] (`ckey`, `effigy_id`, `firstseen`, `firstseen_round_id`, `lastseen`, `lastseen_round_id`, `ip`, `computerid`, `lastadminrank`)
		VALUES (:ckey, :effigy_id, Now(), :round_id, Now(), :round_id, "0", "0", "Player")
	"}, list("ckey" = ckey_to_match, "effigy_id" = input_efid, "round_id" = GLOB.round_id || null))

	if(!query_add_player)
		log_effigy_api("Unable to create SQL query. Check SQL log for details.", notify_admins = TRUE)
		return FALSE

	if(!query_add_player.Execute())
		qdel(query_add_player)
		log_effigy_api("Add player [ckey_to_match] to DB whitelist failed! Check SQL log for details.", notify_admins = TRUE)
		return FALSE

	if(query_add_player.last_error)
		log_effigy_api("Add player [ckey_to_match] to DB whitelist failed! Check runtime log for details.", notify_admins = TRUE)
		stack_trace(query_add_player.last_error)
		qdel(query_add_player)
		return FALSE

	else
		log_effigy_api("Player [ckey_to_match] successfully added to database. Validating.", notify_admins = TRUE)
		qdel(query_add_player)

	log_effigy_api("Player [ckey_to_match] successfully added to database. Validating.", notify_admins = TRUE)
	requested_link = SSeffigy.ckey_to_effigy_id(ckey_to_match)
	if(!requested_link)
		log_effigy_api("Could not find an Effigy ID for ckey [ckey_to_match] in database!", notify_admins = FALSE) // we don't use the default notify since the message is customised and in a div
		message_admins(span_boxannouncered("ckey validation in database for [ckey_to_match] failed! Check SQL log for details."))
		return FALSE
	else
		log_effigy_api("Validation passed for [ckey_to_match].", notify_admins = TRUE)
		return TRUE

/datum/tgs_chat_command/effigy_whitelist
	name = "whitelist"
	help_text = "whitelist <ckey> <effigy_id>"
	admin_only = TRUE

/datum/tgs_chat_command/effigy_whitelist/Run(datum/tgs_chat_user/sender, params)
	if(!CONFIG_GET(flag/sql_enabled))
		return new /datum/tgs_message_content("The Database is not enabled!")

	var/list/all_params = splittext(params, " ")
	if(all_params.len < 2)
		return new /datum/tgs_message_content("Requires both a ckey and an effigy_id!")

	var/input_ckey = ckey(all_params[1])
	if(isnull(input_ckey))
		return new /datum/tgs_message_content("[input_ckey] is not a valid ckey for whitelisting!")

	var/input_efid = text2num(all_params[2])
	if(isnull(input_efid) || input_efid <= 0)
		return new /datum/tgs_message_content("[input_efid] is not a valid effigy_id for whitelisting!")
	input_efid = clamp(input_efid, 0, 99999999)

	log_effigy_api("[sender.friendly_name] is attempting to add [params] to the Effigy whitelist.", notify_admins = TRUE)
	if(effigy_player_insert(input_ckey, input_efid))
		return new /datum/tgs_message_content("[params] has been added to the Effigy whitelist.")
	else
		return new /datum/tgs_message_content("ERROR: [params] was not added to the Effigy whitelist. Check logs for more info.")
