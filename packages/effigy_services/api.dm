SUBSYSTEM_DEF(effigy)
	name = "Effigy Game Services"
	wait = 0.1 SECONDS
	/// The URL of the Effigy API
	var/efapi_url
	/// API authentication method
	var/efapi_auth
	/// Our API key
	var/efapi_key
	/// API endpoints available
	var/list/api_endpoints = list()

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

	for(var/api_endpoint_type in typesof(/datum/effigy_api_endpoint))
		var/datum/effigy_api_endpoint/new_api_endpoint = new(api_endpoint_type)
		api_endpoints[new_api_endpoint.message_type] = new_api_endpoint

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
	var/player_id = 1

	SSeffigy.create_message_request(message_type, box = message_target, peep_id = player_id, peep_message = message_to_send)

/datum/controller/subsystem/effigy/proc/create_message_request(message_type, box, peep_id, peep_title, peep_message)
	if(!efapi_key)
		return

	var/datum/effigy_message/effigy_request = new(
		req_message_type = api_endpoints[message_type],
		req_box = box,
		req_peep_id = peep_id,
		req_peep_title = peep_title,
		req_peep_message = peep_message,
	)

	effigy_request.start_request()

/datum/effigy_message
	/// The endpoint we're using
	var/datum/effigy_api_endpoint/api_endpoint
	/// API message content
	var/list/message_content
	/// HTTP message request
	var/datum/http_request/message_request

/datum/effigy_message/New(req_message_type, req_box, req_peep_id, req_peep_title, req_peep_message)
	api_endpoint = req_message_type
	message_content = list(
		"box" = req_box,
		"peep_id" = req_peep_id,
		"peep_title" = req_peep_title,
		"peep_message" = req_peep_message,
	)

/datum/effigy_message/proc/start_request()
	message_request = api_endpoint.create_http_request(message_content)
	message_request.execute_blocking()
	message_admins("[message_request._raw_response]")

// Cleans up the request object when it is destroyed.
/datum/effigy_message/Destroy(force, ...)
	api_endpoint = null
	QDEL_NULL(message_request)
	return ..()
