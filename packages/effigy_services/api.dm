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

/obj/item/toy/plush/effigy/adminhelp
	name = "admin plushie"
	desc = "Some say speaking to this plushie, you speak to the Gods."
	icon_state = "plushie_skyy"
	attack_verb_continuous = list("kisses", "nuzzles", "cuddles", "purrs against")
	attack_verb_simple = list("kiss", "nuzzle", "cuddle", "purr against")
	squeak_override = list('packages/emotes/assets/voice/nya.ogg' = 1)

/obj/item/toy/plush/effigy/adminhelp/attack_self(mob/user)
	. = ..()
	var/message = tgui_input_text(usr, "Some say speaking to this plushie, you speak to the Gods.", "Heavenly Nya")
	var/title = copytext_char(message, 1, 64)
	var/msg_type = EFFIGY_MESSAGE_NEW_TICKET
	var/box = SOCIAL_DISTRICT_AHELP
	var/link_id = SSeffigy.ckey_to_effigy_id(usr.ckey)

	SSeffigy.create_message_request(msg_type, link_id, box, title, message)

/datum/controller/subsystem/effigy/proc/create_message_request(msg_type, link_id, box, title, message)
	if(!efapi_key)
		return

	var/datum/effigy_message/effigy_request = new(
		msg_type = new msg_type,
		box = box,
		link_id = link_id,
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

/datum/effigy_message/New(msg_type, box, link_id, title, message)
	endpoint = msg_type
	message_content = list(
		"box" = box,
		"link_id" = link_id,
		"title" = title,
		"message" = message,
	)

/datum/controller/subsystem/effigy/proc/start_request(datum/effigy_message/message)
	var/datum/http_request/request = message.endpoint.create_http_request(message.message_content)
	request.begin_async()
	UNTIL(request.is_complete())
	var/datum/http_response/response = request.into_response()
	if(response.errored || response.status_code != 200)
		stack_trace(response.error)
	return response.body

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
	var/query = "SELECT CAST(effigy_id AS CHAR(25)), ckey FROM [format_table_name("effigy_links")] WHERE ckey = :ckey GROUP BY ckey, effigy_id LIMIT 1"
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

/datum/controller/subsystem/effigy/proc/ckey_to_effigy_id(lookup_ckey)
	var/datum/effigy_account_link/link = find_effigy_link_by_ckey(lookup_ckey)
	if(!link)
		stack_trace("Request came back invalid!")
		return
	return link.effigy_id

/client/proc/find_effigy_id(ckeytomatch as text)
	set category = "Admin"
	set name = "Find Effigy ID"
	set desc = "Find the Effigy account linked to a ckey."

	var/requested_link = 0
	to_chat(usr, span_info("Searching Effigy for [ckeytomatch]"))
	requested_link = SSeffigy.ckey_to_effigy_id(ckeytomatch)
	if(!requested_link)
		to_chat(usr, span_notice("Could not find an Effigy ID for ckey [ckeytomatch]!"))
	else
		to_chat(usr, span_notice("Found Effigy ID [requested_link] for ckey [ckeytomatch]!"))

