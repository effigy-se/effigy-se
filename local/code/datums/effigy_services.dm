/datum/effigy_message
	/// Message type of request
	var/endpoint
	/// API URL of the endpoint
	var/url
	/// The HTTP method of this endpoint
	var/method

/// Generates the request header
/datum/effigy_message/proc/construct_extra_headers(efapi_auth, efapi_key)
	return list()

/// Generates the request body
/datum/effigy_message/proc/construct_api_message_body()
	CRASH("construct_api_message_body() not overridden")

/datum/effigy_message/forum
	var/box
	var/int_id
	var/link_id
	var/ticket_id
	var/title
	var/message

/datum/effigy_message/forum/New(box, int_id, ticket_id, link_id, title, message)
	src.box = box
	src.int_id = int_id
	src.ticket_id = ticket_id
	src.link_id = link_id
	src.title = title
	src.message = message

/datum/effigy_message/forum/new_ticket
	endpoint = EFFIGY_ENDPOINT_NEW_TICKET
	method = RUSTG_HTTP_METHOD_POST

/datum/effigy_message/forum/ticket_interaction
	endpoint = EFFIGY_ENDPOINT_TICKET_INTERACTION
	method = RUSTG_HTTP_METHOD_POST

/datum/effigy_message/forum/construct_api_message_body(list/raw_content)
	var/list/processed_content = list(
		"forum=[box]",
		"author=[int_id]",
		"topic=[ticket_id]",
		"title=\[[int_id]] [title]",
		"post=[jointext(message, "<br>")]"
	)

	var/joined = jointext(processed_content, "&")
	return joined

/datum/effigy_account_link
	var/ckey
	var/effigy_id

/datum/effigy_account_link/New(ckey, effigy_id)
	src.ckey = ckey
	src.effigy_id = effigy_id
