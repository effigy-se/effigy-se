/datum/http_request
	var/id
	var/in_progress = FALSE

	var/method
	var/body
	var/headers
	var/url
	/// If present response body will be saved to this file.
	var/output_file

	var/_raw_response

/datum/http_request/proc/prepare(method, url, body = "", list/headers, output_file)
	if (!length(headers))
		headers = ""
	else
		headers = json_encode(headers)

	src.method = method
	src.url = url
	src.body = body
	src.headers = headers
	src.output_file = output_file

/datum/http_request/proc/execute_blocking()
	_raw_response = rustg_http_request_blocking(method, url, body, headers, build_options())

/datum/http_request/proc/begin_async()
	if (in_progress)
		log_game("Attempted to re-use a request object.")
		CRASH("Attempted to re-use a request object.")

	log_game("package rustg", method, url, body, headers)
	id = rustg_http_request_async(method, url, body, headers, build_options())

	if (isnull(text2num(id)))
		log_game("Proc error: [id]")
		stack_trace("Proc error: [id]")
		_raw_response = "Proc error: [id]"
	else
		log_game("rustg in progress")
		in_progress = TRUE

/datum/http_request/proc/build_options()
	if(output_file)
		return json_encode(list("output_filename"=output_file,"body_filename"=null))
	return null

/datum/http_request/proc/is_complete()
	if (isnull(id))
		return TRUE

	if (!in_progress)
		return TRUE

	var/r = rustg_http_check_request(id)

	if (r == RUSTG_JOB_NO_RESULTS_YET)
		log_game("RUSTG_JOB_NO_RESULTS_YET")
		return FALSE
	else
		_raw_response = r
		log_game("response [r]", r)
		in_progress = FALSE
		return TRUE

/datum/http_request/proc/into_response()
	var/datum/http_response/R = new()

	try
		var/list/L = json_decode(_raw_response)
		log_game("status_code [L["status_code"]]")
		R.status_code = L["status_code"]
		log_game("headers [L["headers"]]")
		R.headers = L["headers"]
		log_game("body [L["body"]]")
		R.body = L["body"]
	catch
		log_game("rustg error")
		R.errored = TRUE
		log_game("error response [_raw_response]", _raw_response)
		R.error = _raw_response

	return R

/datum/http_response
	var/status_code
	var/body
	var/list/headers

	var/errored = FALSE
	var/error
