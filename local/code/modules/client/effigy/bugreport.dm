/client/verb/effigy_issue_report()
	set name = "effigy-issue"
	set desc = "Report an issue"
	set hidden = TRUE
	/// Unique ID of the report
	var/event_id = generate_evid()
	/// API endpoint required
	var/ef_type = EFFIGY_MESSAGE_NEW_TICKET
	/// What kind of message we're sendsing
	var/ef_box = SOCIAL_DISTRICT_ISSUE_REPORT
	/// The title of the report
	var/title
	/// The bug report content
	var/content
	/// The time at which the ticket was opened
	var/world_time = world.time
	/// The ckey of the reporter
	var/player_ckey = src.ckey
	/// The EFID of the reporter
	var/effigy_player_id = SSeffigy.ckey_to_effigy_id(player_ckey)
	/// We don't have a ref ticket for issue reports
	var/effigy_ticket_id = 0

	if(!effigy_player_id)
		to_chat(src, type = MESSAGE_TYPE_SYSTEM, html = SPAN_BOX_ALERT(RED, "Failed to start a new Issue Report: Please create an Issue Report to report this issue."))
		to_chat(src, type = MESSAGE_TYPE_SYSTEM, html = SPAN_BOX_ALERT(RED, "Alternatively, scream into the void. Both are equally effective options right now."))
		return

	title = tgui_input_text(src, message = "", title = "Issue Report - Title", max_length = 128, multiline = FALSE, encode = TRUE, timeout = 0)

	if(!title)
		to_chat(src, type = MESSAGE_TYPE_SYSTEM, html = SPAN_BOX_ALERT(RED, "Failed to start a new Issue Report: You need to put a title for the submission!"))
		return

	content = tgui_input_text(src, message = "", title = "Detailed issue description", max_length = MAX_MESSAGE_LEN, multiline = TRUE, encode = TRUE, timeout = 0)

	if(!content)
		to_chat(src, type = MESSAGE_TYPE_SYSTEM, html = SPAN_BOX_ALERT(RED, "Failed to start a new Issue Report: You need to put content in the submission!"))
		return

	var/server_rev = copytext(GLOB.revdata.commit, 1, 8)
	var/round_real_time = REALTIMEOFDAY - SSticker.round_start_real_time
	var/list/issue_metadata = list(
			"Reporting client: [key_name(player_ckey)]",
			"Reporting client version: [byond_version].[byond_build]",
			"Time Dilation: [round(SStime_track.time_dilation_current,1)]% (Average: [round(SStime_track.time_dilation_avg_fast,1)]% / [round(SStime_track.time_dilation_avg,1)]% / [round(SStime_track.time_dilation_avg_slow,1)]%)",
			"Map: [SSmapping.config?.map_name || ""]",
			"Round ID: [GLOB.round_hex ? GLOB.round_hex : ""]-[GLOB.round_id ? GLOB.round_id : ""]",
			"Server Rev: [server_rev ? server_rev : "N/A"]",
			"Server Time: [time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")]",
			"World Time: [world_time]",
			"[SSticker.HasRoundStarted() ? "Round Time: [ROUND_TIME()]" : "Pre/Post Game Lobby"]",
			"[SSticker.HasRoundStarted() ? "Adj. Round Time: [time2text(round_real_time, "hh:mm:ss", 0)]" : "N/A"]",
			"<br>",
		)

	var/list/test_merges
	var/githuburl = CONFIG_GET(string/githuburl)
	LAZYINITLIST(test_merges)
	if(GLOB.revdata.testmerge.len)
		for(var/entry in GLOB.revdata.testmerge)
			var/datum/tgs_revision_information/test_merge/tm = entry
			test_merges += "- \[[tm.title]\]([githuburl]/pull/[tm.number])"
		var/all_tms_joined = test_merges.Join("\n") // for some reason this can't go in the []
		LAZYADD(test_merges, "TMs:\n")
		LAZYADD(test_merges, "TMs:\n[all_tms_joined]")

	var/processed_content
	LAZYINITLIST(processed_content)
	LAZYADD(processed_content, issue_metadata)
	LAZYADD(processed_content, test_merges)
	LAZYADD(processed_content, title)
	LAZYADD(processed_content, content)
	var/request = SSeffigy.create_message_request(ef_type, event_id, effigy_player_id, effigy_ticket_id, ef_box, title, processed_content)
	INVOKE_ASYNC(SSeffigy, TYPE_PROC_REF(/datum/controller/subsystem/effigy, send_message_request), request, src)
	log_game("Issue report created: [event_id] [content]")
	to_chat(src, type = MESSAGE_TYPE_SYSTEM, html = SPAN_BOX_ALERT(BLUE, "Issue Report: [event_id] created."))


