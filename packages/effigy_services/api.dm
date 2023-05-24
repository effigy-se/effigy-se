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
	var/message_to_send = "Nya nya nya, cattes!"
	var/message_type = EFFIGY_MESSAGE_NEW_TICKET
	var/message_target = SOCIAL_DISTRICT_AHELP
	var/effigy_link = SSeffigy.find_effigy_link_by_ckey(ckey(user.key))

	SSeffigy.create_message_request(message_type, box = message_target, peep_id = effigy_link, peep_message = message_to_send)

/datum/controller/subsystem/effigy/proc/create_message_request(message_type, box, peep_id, peep_title, peep_message)
	if(!efapi_key)
		return

	var/datum/effigy_message/effigy_request = new(
		req_message_type = new message_type,
		req_box = box,
		req_peep_id = peep_id,
		req_peep_title = peep_title,
		req_peep_message = peep_message,
	)

	start_request(effigy_request)

/datum/effigy_message
	/// The endpoint we're using
	var/datum/effigy_message_type/endpoint
	/// API message content
	var/list/message_content
	/// HTTP message request
	var/datum/http_request/message_request

/datum/effigy_message/New(req_message_type, req_box, req_peep_id, req_peep_title, req_peep_message)
	endpoint = req_message_type
	message_content = list(
		"box" = req_box,
		"peep_id" = req_peep_id,
		"peep_title" = req_peep_title,
		"peep_message" = req_peep_message,
	)

/datum/controller/subsystem/effigy/proc/start_request(datum/effigy_message/message)
	var/datum/http_request/request = message.endpoint.create_http_request(message.message_content)
	request.begin_async()
	UNTIL(request.is_complete())
	var/datum/http_response/response = request.into_response()
	if(response.errored || response.status_code != 200)
		stack_trace(response.error)

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
	var/query = "SELECT CAST(effigy_id AS CHAR(25)), ckey, FROM [format_table_name("effigy_links")] WHERE ckey = :ckey GROUP BY ckey, effigy_id LIMIT 1"
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

/client/proc/findeffigylink(ckeytolink as text)
	set category = "Admin"
	set name = "Find Effigy Link"
	set desc = "Find the Effigy account link for a ckey."

	message_admins("Searching for [ckeytolink]")
	var/datum/effigy_account_link/player
	player = SSeffigy.find_effigy_link_by_ckey(ckeytolink)
	message_admins("Found [player.ckey] [player.effigy_id]")
