//world/proc/shelleo
#define SHELLEO_ERRORLEVEL 1
#define SHELLEO_STDOUT 2
#define SHELLEO_STDERR 3

/proc/play_lobby_track(selected_track)
	var/ytdl = CONFIG_GET(string/invoke_youtubedl)
	if(!ytdl)
		log_game("Youtube-dl was not configured, lobby music unavailable") //Check config.txt for the INVOKE_YOUTUBEDL value
		return

	if(S_TIMER_COOLDOWN_TIMELEFT(SStimer, COOLDOWN_INTERNET_SOUND))
		log_game("An internet track is already playing. Skipping lobby music.")
		return

	if(length(selected_track))
		selected_track = trim(selected_track)
		selected_track = shell_url_scrub(selected_track)
		if(findtext(selected_track, ":") && !findtext(selected_track, GLOB.is_http_protocol))
			log_game("Error in attempt to start lobby music track: Invalid URL [selected_track]")
			return

	var/web_sound_url = ""
	var/list/music_extra_data = list()

	if(!istext(selected_track))
		return

	var/list/output = world.shelleo("[ytdl] --geo-bypass --format \"bestaudio\[ext=mp3]/best\[ext=mp4]\[height <= 360]/bestaudio\[ext=m4a]/bestaudio\[ext=aac]\" --dump-single-json --no-playlist -- \"[selected_track]\"")
	var/errorlevel = output[SHELLEO_ERRORLEVEL]
	var/stdout = output[SHELLEO_STDOUT]
	var/stderr = output[SHELLEO_STDERR]
	if(errorlevel)
		log_game("Error in attempt to start lobby music track: [stderr]")
		return
	var/list/data
	try
		data = json_decode(stdout)
	catch(var/exception/e)
		log_game("Youtube-dl JSON parsing FAILED:")
		log_game("[e]: [stdout]")
		return
	if(data["url"])
		web_sound_url = data["url"]
	music_extra_data["title"] = "Lobby Music Track"

	if(web_sound_url && !findtext(web_sound_url, GLOB.is_http_protocol))
		log_game("The media provider returned a content URL that isn't using the HTTP or HTTPS protocol. This is a security risk and the sound will not be played.")
		return

	if(isnull(web_sound_url))
		return

	for(var/connection in GLOB.player_list)
		var/mob/player_mob = connection
		var/client/player_client = player_mob.client
		if(player_client.prefs.read_preference(/datum/preference/toggle/sound_lobby))
			player_client.tgui_panel?.play_music(web_sound_url, music_extra_data)

//world/proc/shelleo
#undef SHELLEO_ERRORLEVEL
#undef SHELLEO_STDOUT
#undef SHELLEO_STDERR
