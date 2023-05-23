/// Effigy API Endpoint Config
/datum/effigy_api_endpoint
	/// Path of the API endpoint
	var/message_type = EFFIGY_MESSAGE_NEW_TICKET
	// API URL of the endpoint
	var/url
	/// The HTTP method of this endpoint
	var/method = RUSTG_HTTP_METHOD_POST

/// Generates the request header
/datum/effigy_api_endpoint/proc/build_api_message_header(efapi_auth, efapi_key)
	var/list/processed_content = list(
		"Authorization" = "[efapi_auth] [efapi_key]",
		"Content-Type" = "application/json"
		)
	return processed_content

/// Generates the request body
/datum/effigy_api_endpoint/proc/build_api_message_body(list/raw_content)
	var/list/processed_content = list(
		EFFIGY_MESSAGE_NEW_TICKET,
		"forum" = "[raw_content["box"]]",
		"title" = "new ticket",
		"post" = "[raw_content["peep_message"]]",
		"author" = "[raw_content["peep_id"]]"
	)
	return processed_content

/datum/effigy_api_endpoint/proc/create_http_request(content)
	// Set up the required headers for the Effigy API
	var/list/headers = build_api_message_header(SSeffigy.efapi_auth, SSeffigy.efapi_key)

	// Create the JSON body for the request
	var/list/body = build_api_message_body(content)

	// Encode the json for export
	var/body_json = json_encode(body)

	// Make the API URL
	url = "[SSeffigy.efapi_url]?[message_type]"

	// Create a new HTTP request
	var/datum/http_request/request = new()

	// Set up the HTTP request
	request.prepare(method, url, body_json, headers)

	return request
