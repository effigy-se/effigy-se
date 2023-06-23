SUBSYSTEM_DEF(effigy)
	name = "Effigy Game Services"
	wait = 0.1 SECONDS
	flags = SS_NO_FIRE

	/// The URL of the Effigy API
	var/efapi_url
	/// API authentication method
	var/efapi_auth
	/// Our API key
	var/efapi_key

/datum/effigy_account_link
	var/ckey
	var/effigy_id

/datum/effigy_account_link/New(ckey, effigy_id)
	src.ckey = ckey
	src.effigy_id = effigy_id

/datum/controller/subsystem/effigy/Initialize()
	// Check for enable
	if(!CONFIG_GET(flag/use_effigy_api))
		return SS_INIT_NO_NEED

	// Check for API config
	efapi_url = CONFIG_GET(string/effigy_api_url)
	efapi_auth = CONFIG_GET(string/effigy_api_auth)
	efapi_key = CONFIG_GET(string/effigy_api_key)

	if(!efapi_key || !efapi_key)
		return SS_INIT_NO_NEED

	return SS_INIT_SUCCESS

/datum/controller/subsystem/effigy/Destroy()
	return ..()

/datum/controller/subsystem/effigy/proc/create_message_request(msg_type, int_id, link_id, ticket_id, box, title, message)
	if(!efapi_key)
		return

	var/datum/effigy_message/effigy_request = new(
		msg_type = new msg_type,
		int_id = int_id,
		link_id = link_id,
		ticket_id = ticket_id,
		box = box,
		title = title,
		message = message,
	)

	return effigy_request

/datum/effigy_message
	/// The endpoint we're using
	var/datum/effigy_message_type/endpoint
	/// API message content
	var/list/message_content
	/// HTTP message request
	var/datum/http_request/message_request

/datum/effigy_message/New(msg_type, box, int_id, ticket_id, link_id, title, message)
	endpoint = msg_type
	message_content = list(
		"box" = box,
		"int_id" = int_id,
		"link_id" = link_id,
		"ticket_id" = ticket_id,
		"title" = title,
		"message" = message,
	)

/datum/controller/subsystem/effigy/proc/send_message_request(datum/effigy_message/message)
	var/datum/http_request/request = message.endpoint.create_http_request(message.message_content)
	request.begin_async()
	UNTIL(request.is_complete())
	var/datum/http_response/response = request.into_response()
	if(response.errored)
		stack_trace(response.error)
	return json_decode(response.body)

// Cleans up the request object when it is destroyed.
/datum/effigy_message/Destroy(force, ...)
	endpoint = null
	QDEL_NULL(message_request)
	return ..()

/**
 * Find Effigy link entry by the passed in user ckey
 *
 * This will look into the discord link table and return the entry that matches the given ckey
 *
 * Arguments:
 * * ckey the users ckey as a string
 *
 * Returns a [/datum/effigy_account_link]
 */
/datum/controller/subsystem/effigy/proc/find_effigy_link_by_ckey(ckey)
	var/query = "SELECT CAST(effigy_id AS CHAR(25)), ckey FROM [format_table_name("player")] WHERE ckey = :ckey GROUP BY ckey, effigy_id LIMIT 1"
	var/datum/db_query/query_get_effigy_link_record = SSdbcore.NewQuery(
		query,
		list("ckey" = ckey)
	)
	if(!query_get_effigy_link_record.Execute())
		qdel(query_get_effigy_link_record)
		return

	if(query_get_effigy_link_record.NextRow())
		var/result = query_get_effigy_link_record.item
		. = new /datum/effigy_account_link(result[2], result[1])

/datum/controller/subsystem/effigy/proc/create_effigy_link_by_ckey(ckey, effigyid)
	var/query = "UPDATE [format_table_name("player")] SET effigy_id = :effigyid WHERE ckey = :ckey"
	var/datum/db_query/query_set_effigy_link_record = SSdbcore.NewQuery(
		query,
		list(
		"effigyid" = effigyid,
		"ckey" = ckey)
		)
	if(!query_set_effigy_link_record.Execute())
		qdel(query_set_effigy_link_record)
		return FALSE

	return TRUE

/datum/controller/subsystem/effigy/proc/ckey_to_effigy_id(lookup_ckey)
	var/datum/effigy_account_link/link = find_effigy_link_by_ckey(lookup_ckey)
	if(!link)
		stack_trace("Request came back invalid!")
		return
	return link.effigy_id

/datum/controller/subsystem/effigy/proc/link_effigy_id_to_ckey(lookup_ckey, effigyid)
	var/datum/effigy_account_link/existing_link = find_effigy_link_by_ckey(lookup_ckey)
	if(existing_link)
		if(existing_link.effigy_id != "0")
			to_chat(usr, span_info("Link for [lookup_ckey] already exists! Found [existing_link.effigy_id]."))
			return
	if(create_effigy_link_by_ckey(lookup_ckey, effigyid))
		var/new_link = ckey_to_effigy_id(lookup_ckey)
		to_chat(usr, span_notice("Linked Effigy ID [new_link] for ckey [lookup_ckey]!"))
	else
		to_chat(usr, span_notice("Effigy link for ckey [lookup_ckey] failed!"))

/client/proc/find_effigy_id()
	set category = "Admin"
	set name = "Effigy ID Search"
	set desc = "Find the Effigy account linked to a ckey."
	var/ckeytomatch = tgui_input_text(src, "What is their ckey?", "Who could it be now?~")
	var/requested_link = 0
	to_chat(usr, span_info("Searching Effigy for [ckeytomatch]"))
	requested_link = SSeffigy.ckey_to_effigy_id(ckeytomatch)
	if(!requested_link)
		to_chat(usr, span_notice("Could not find an Effigy ID for ckey [ckeytomatch]!"))
	else
		to_chat(usr, span_notice("Found Effigy ID [requested_link] for ckey [ckeytomatch]!"))

/client/proc/link_effigy_id()
	set category = "Admin"
	set name = "Effigy ID Link"
	set desc = "Link an Effigy account to a ckey"
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, span_adminnotice("The Database is not enabled!"))
		return

	var/ckeytomatch = tgui_input_text(src, "What is their ckey?", "Someone wants to play here, apparently.")
	var/effigyid = tgui_input_number(src, "What is their Effigy ID?", "Someone wants to play here, apparently.", max_value = 99999999, min_value = 1, default = 0)

	to_chat(usr, span_info("Searching Effigy for [ckeytomatch]"))
	SSeffigy.link_effigy_id_to_ckey(ckeytomatch, effigyid)

/client/proc/effigy_whitelist()
	set category = "Admin"
	set name = "Whitelist Player"
	set desc = "Link an Effigy account to a ckey and add to whitelist"
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, span_adminnotice("The Database is not enabled!"))
		return

	var/ckeytomatch = tgui_input_text(src, "What is their ckey?", "Someone wants to play here, apparently.")
	var/effigyid = tgui_input_number(src, "What is their Effigy ID?", "Someone wants to play here, apparently.", max_value = 99999999, min_value = 1, default = 0)

	GLOB.bunker_passthrough |= ckey(ckeytomatch)
	GLOB.bunker_passthrough[ckey(ckeytomatch)] = world.realtime
	SSpersistence.save_panic_bunker()
	to_chat(usr, span_info("[ckeytomatch] added to panic bunker bypass."))

	to_chat(usr, span_info("Searching Effigy for [ckeytomatch]"))
	SSeffigy.link_effigy_id_to_ckey(ckeytomatch, effigyid)

/proc/generate_effigy_event_id()
	var/evid = null
	if(!GLOB.round_id)
		evid = text2num("[rand(0,999)][rand(0,9999)]")
		evid = num2text(evid, 7, 16)
		return evid
	evid = text2num("[GLOB.round_id][num2text(GLOB.current_effigy_evid, 3, 10)]")
	evid = num2text(evid, 7, 16)
	GLOB.current_effigy_evid++
	return evid
