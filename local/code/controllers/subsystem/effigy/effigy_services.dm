SUBSYSTEM_DEF(effigy)
	name = "Effigy Game Services"
	wait = 0.1 SECONDS
	init_order = INIT_ORDER_EFFIGY
	flags = SS_NO_FIRE

	/// The URL of the Effigy API
	var/efapi_url
	/// API authentication method
	var/efapi_auth
	/// Our API key
	var/efapi_key

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

/datum/controller/subsystem/effigy/proc/send_message_request(datum/effigy_message/message, datum/admin_help/ticket)
	set waitfor = FALSE
	var/datum/http_request/request = message.endpoint.create_http_request(message.message_content)
	request.begin_async()
	UNTIL(request.is_complete())
	var/datum/http_response/response = request.into_response()
	if(response.errored)
		log_effigy_api("ERROR: [response.error] received for ticket [ticket.id]")
		stack_trace(response.error)
	SEND_SIGNAL(src, COMSIG_EFFIGY_API_RESPONSE, ticket, json_decode(response.body))

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
	if(!SSdbcore.Connect())
		to_chat(usr, span_warning("Database connectivity failed!"))
		return
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
	qdel(query_get_effigy_link_record)

/datum/controller/subsystem/effigy/proc/create_effigy_link_by_ckey(ckey, effigyid)
	var/query = "UPDATE [format_table_name("player")] SET effigy_id = :effigyid WHERE ckey = :ckey"
	if(!SSdbcore.Connect())
		to_chat(usr, span_warning("Database connectivity failed!"))
		return FALSE
	var/datum/db_query/query_set_effigy_link_record = SSdbcore.NewQuery(
		query,
		list(
		"effigyid" = effigyid,
		"ckey" = ckey)
		)
	if(!query_set_effigy_link_record.Execute())
		qdel(query_set_effigy_link_record)
		return FALSE

	qdel(query_set_effigy_link_record)
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
			log_admin_private("[usr] attempted to link Effigy ID [effigyid] to ckey [lookup_ckey], but it failed")
			message_admins(span_notice("Link for [lookup_ckey] already exists! Found [existing_link.effigy_id]."))
			return
	if(create_effigy_link_by_ckey(lookup_ckey, effigyid))
		var/new_link = ckey_to_effigy_id(lookup_ckey)
		log_admin_private("[usr] linked Effigy ID [new_link] to ckey [lookup_ckey]")
		message_admins(span_notice("Linked Effigy ID [new_link] for ckey [lookup_ckey]!"))
	else
		log_admin_private("[usr] attempted to link Effigy ID [effigyid] to ckey [lookup_ckey], but it failed")
		message_admins(span_notice("Effigy link attempt for ckey [lookup_ckey] failed!"))

/client/proc/find_effigy_id()
	set category = "Admin"
	set name = "Effigy ID Search"
	set desc = "Find the Effigy account linked to a ckey."
	var/input_key = tgui_input_text(src, "What is their ckey?", "Who could it be now?~")
	var/ckeytomatch = ckey(input_key)
	var/requested_link = 0
	message_admins(span_info("Searching Effigy for [ckeytomatch]"))
	requested_link = SSeffigy.ckey_to_effigy_id(ckeytomatch)
	if(!requested_link)
		message_admins(span_notice("Could not find an Effigy ID for ckey [ckeytomatch]!"))
	else
		message_admins(span_notice("Found Effigy ID [requested_link] for ckey [ckeytomatch]!"))

/client/proc/link_effigy_id()
	set category = "Admin"
	set name = "Effigy ID Link"
	set desc = "Link an Effigy account to a ckey"
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(usr, span_adminnotice("The Database is not enabled!"))
		return

	var/input_key = tgui_input_text(src, "What is their ckey?", "Someone wants to play here, apparently.")
	var/ckeytomatch = ckey(input_key)
	var/effigyid = tgui_input_number(src, "What is their Effigy ID?", "Someone wants to play here, apparently.", max_value = 99999999, min_value = 1, default = 0)

	message_admins(span_info("Searching Effigy for [ckeytomatch]"))
	SSeffigy.link_effigy_id_to_ckey(ckeytomatch, effigyid)

/proc/generate_evid()
	var/evid
	if(GLOB.current_effigy_evid > 1023)
		CRASH("Run out of EVIDs to allocate in round.")
	evid = text2num(GLOB.round_id) * 1024 + GLOB.current_effigy_evid
	GLOB.current_effigy_evid++
	return num2text(evid, 9, 16)

/proc/find_byond_age(ckey)
	var/list/http = world.Export("http://byond.com/members/[ckey]?format=text")
	if(!http)
		log_world("Failed to connect to byond member page to age check [ckey]")
		return
	var/F = file2text(http["CONTENT"])
	if(F)
		var/regex/R = regex("joined = \"(\\d{4}-\\d{2}-\\d{2})\"")
		if(R.Find(F))
			. = R.group[1]
		else
			CRASH("Age check regex failed for [ckey]")

/proc/set_effigy_live()
	var/local_ref
	if(GLOB.revdata.commit && GLOB.revdata.commit != GLOB.revdata.originmastercommit)
		local_ref = copytext(GLOB.revdata.commit, 1, 8)
	else
		local_ref = copytext(GLOB.revdata.originmastercommit, 1, 8)
	rustg_file_write(local_ref, ".effigy_live")
