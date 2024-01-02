/// Effigy API Endpoint Config
/datum/effigy_message_type
	/// Message type of request
	var/endpoint
	/// API URL of the endpoint
	var/url
	/// The HTTP method of this endpoint
	var/method

/datum/effigy_message_type/new_ticket
	endpoint = EFFIGY_ENDPOINT_NEW_TICKET
	method = RUSTG_HTTP_METHOD_POST

/datum/effigy_message_type/ticket_interaction
	endpoint = EFFIGY_ENDPOINT_TICKET_INTERACTION
	method = RUSTG_HTTP_METHOD_POST

/datum/effigy_message_type/get
	method = RUSTG_HTTP_METHOD_GET

/// Generates the request header
/datum/effigy_message_type/proc/construct_api_message_header(efapi_auth, efapi_key)
	var/list/processed_content = list(
		"Authorization" = "[efapi_auth] [efapi_key]",
		"content-type" = "application/x-www-form-urlencoded"
		)
	return processed_content

/// Generates the request body
/datum/effigy_message_type/proc/construct_api_message_body(list/raw_content)
	var/list/processed_content = list(
		"forum" = "[raw_content["box"]]",
		"author" = "[raw_content["link_id"]]",
		"topic" = "[raw_content["ticket_id"]]",
		"title" = "\[[raw_content["int_id"]]] [raw_content["title"]]",
		"post" = "[jointext(raw_content["message"], "<br>")]"
	)

	var/list/parsed_content = list()
	for(var/urlkey in processed_content)
		parsed_content.Add("[urlkey]=[url_encode(processed_content[urlkey])]")

	var/joined = jointext(parsed_content, "&")
	return joined

/datum/effigy_message_type/proc/create_http_request(content)
	// Set up the required headers for the Effigy API
	var/list/headers = construct_api_message_header(SSeffigy.efapi_auth, SSeffigy.efapi_key)

	// Create the JSON body for the request
	var/body = construct_api_message_body(content)

	// Make the API URL
	url = "[SSeffigy.efapi_url][endpoint]"

	// Create a new HTTP request
	var/datum/http_request/request = new()

	// Set up the HTTP request
	request.prepare(method, url, body, headers)

	return request

/datum/effigy_account_link
	var/ckey
	var/effigy_id

/datum/effigy_account_link/New(ckey, effigy_id)
	src.ckey = ckey
	src.effigy_id = effigy_id
