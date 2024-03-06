/datum/controller/subsystem/ticker
	/// Did we broadcast at players to hurry up?
	var/launch_queued = FALSE
	/// Did we broadcast the start time?
	var/hr_announce_fired = FALSE
	/// UTC time of round start
	var/round_start_real_time = 0
	/// Have we started the lobby music
	var/lobby_track_fired = FALSE
	/// What is the lobby track this round
	var/lobby_track_id
	/// How long is the lobby track
	var/lobby_track_duration

/proc/discord_new_game_alert()
	send2chat(new /datum/tgs_message_content("<@&[CONFIG_GET(string/game_notify_role_id)]> Round **[GLOB.round_hex]** starting on [SSmapping.config.map_name]! \nTo subscribe to game related pings, go to <#[CONFIG_GET(string/channel_role_assignment)]> and pick your roles."), CONFIG_GET(string/channel_announce_new_game))
	send2chat(new /datum/tgs_message_content("[GLOB.station_name] shift starting on [SSmapping.config.map_name]!"), CONFIG_GET(string/channel_social_new_game))

/proc/discord_end_game_alert(message)
	send2chat("<@&[CONFIG_GET(string/game_notify_role_id)]> [message]", CONFIG_GET(string/channel_announce_end_game))
	send2chat(message, CONFIG_GET(string/channel_social_end_game))

/datum/controller/subsystem/ticker/proc/load_effigy_lobby_tracks()
	lobby_track_id = CONFIG_GET(string/pregame_lobby_track)
	if(isnull(lobby_track_id))
		log_game("No lobby music track ID configuration found!")
		lobby_track_fired = TRUE
		lobby_track_duration = -2
	lobby_track_duration = CONFIG_GET(number/pregame_lobby_duration)
	if(isnull(lobby_track_duration))
		log_game("No lobby music track duration configuration found!")
		lobby_track_duration = -3

/datum/controller/subsystem/ticker/proc/queue_game_start(time_override)
	if(isnull(time_override) || !isnum(time_override))
		CRASH("Queue Game Start called without a valid time override")

	timeLeft = time_override
	log_game("Game start queued in [DisplayTimeText(time_override)]")

	if(time_override <= 94 SECONDS)
		hr_announce_fired = TRUE
		lobby_track_fired = FALSE

	queue_game_start_announcement()

/datum/controller/subsystem/ticker/proc/queue_game_start_announcement()
	var/announce_time = round(timeLeft, 10 SECONDS)
	var/list/announcement_strings = list()
	var/header = span_major_announcement_title("Shift Start Update")
	header += span_subheader_announcement_text("Central Command Organic Resources")
	announcement_strings += span_announcement_header(header)
	announcement_strings += span_major_announcement_text("[command_name()] is currently finalizing [GLOB.round_hex ? "crew manifest ID [GLOB.round_hex]" : "the crew manifest"] for today's shift aboard [station_name()].<br/><br/>In [DisplayTimeText(announce_time)] the crew manifest will be locked and station onboarding at [SSmapping.config.map_name] will begin.<br/><br/>All crew are advised to verify their 'Ready' status in your personnel profile before this time. Once the manifest is locked, please consult your assigned Head of Personnel for any further organic resources requests.")
	var/finalized_announcement = create_announcement_div(jointext(announcement_strings, ""), PURPLE)
	to_chat(world, finalized_announcement)
	for(var/mob/player in GLOB.player_list)
		if(player.client?.prefs.read_preference(/datum/preference/toggle/sound_announcements))
			SEND_SOUND(player, sound('sound/ai/default/attention.ogg'))
