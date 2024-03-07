GLOBAL_LIST_EMPTY(startup_messages)

#define MAX_STARTUP_MESSAGES 1

/mob/dead/new_player/proc/get_title_html()
	var/splash_data = SStitle.title_html
	if(SSticker.current_state == GAME_STATE_STARTUP)
		splash_data += {"<img src="title-x3.png" class="bg" alt="">"}
		splash_data += {"<div class="container_terminal" id="terminal"></div>"}
		splash_data += {"<div class="container_progress" id="progress_container"><div class="progress_bar" id="progress"><div class="sub_progress_bar" id="sub_progress"></div></div></div>"}

		splash_data += {"
		<script language="JavaScript">
			var terminal = document.getElementById("terminal");
			var terminal_lines = \[
		"}

		for(var/message in GLOB.startup_messages)
			splash_data += {""[replacetext(message, "\"", "\\\"")]","}

		splash_data += {"
			\];

			function append_terminal_text(text) {
				if(text) {
					terminal_lines.push(text);
				}
				while(terminal_lines.length > [MAX_STARTUP_MESSAGES]) {
					terminal_lines.shift();
				}

				terminal.innerHTML = terminal_lines.join("");
			}

			append_terminal_text();

			var progress_bar = document.getElementById("progress");
			var sub_progress_bar = document.getElementById("sub_progress");
			var progress_container = document.getElementById("progress_container");
			// milliseconds, the actual realtime tick number
			var previous_tick = new Date().getTime();
			// These times are all in 10ths of a second, like byond.
			var progress_current_time = [world.timeofday - SStitle.progress_reference_time];
			var progress_completion_time = [SStitle.average_completion_time];
			// Current progress bar position from 0-100
			var progress_current_position = 0;
			// Current start position from 0-100 of subprogress area. Zooming towards target_sub_start.
			var progress_sub_start = 0;
			// Target start position of progress area. A captured value of progress_current_position.
			var target_sub_start = 0;

			setInterval(function() {
				// Compensate for shakey execution.
				if(progress_current_time < progress_completion_time) {
					var current_tick = new Date().getTime();
					progress_current_time += (current_tick - previous_tick) / 100;
					previous_tick = current_tick;
				}

				// Bound the new position between the old pos and 100: only go forwards
				progress_current_position = Math.min(Math.max(progress_current_time / progress_completion_time * 100, progress_current_position), 100);

				if(progress_sub_start == 0) {
					// person just connected, jump to current real progress pos.
					progress_sub_start = target_sub_start = progress_current_position;
				} else {
					// Animate the sub-progress position; requires old and new progress bar pos to know speed.
					progress_sub_start = Math.min(progress_sub_start + 0.1, target_sub_start);
				}

				// Recalculate gap as a % within a % since they're nested.
				var progress_sub_current_position = (progress_current_position - progress_sub_start) / progress_current_position * 100;

				progress_bar.style.width = "" + progress_current_position + "%";
				sub_progress_bar.style.width = "" + progress_sub_current_position + "%";
			}, 16.666666667);

			function update_loading_progress(current_time, total_time) {
				progress_current_time = parseFloat(current_time);
				progress_completion_time = parseFloat(total_time);
				target_sub_start = progress_current_position;
			}

			function update_current_character() {}
		</script>
		"}

	else
		splash_data += {"<img src="title-x3.png" class="bg" alt="">"}

		if(SStitle.current_notice)
			splash_data += {"
			<div class="container_notice">
				<p class="menu_notice">[SStitle.current_notice]</p>
			</div>
		"}

		splash_data += {"<div class="container_nav">"}

		if(!SSticker || SSticker.current_state <= GAME_STATE_PREGAME)
			splash_data += {"
				<a id="ready" class="menu_button" href='?src=[text_ref(src)];toggle_ready=1'>[ready == PLAYER_READY_TO_PLAY ? "<span class='cta'>Ready</span>" : "Not Ready"]</a>
			"}
		else
			splash_data += {"
				<a class="menu_button" href='?src=[text_ref(src)];late_join=1'><span class='cta'>Join Game</span></a>
			"}

		splash_data += {"
			<a id="be_antag" class="menu_button" href='?src=[text_ref(src)];toggle_antag=1'>[client.prefs.read_preference(/datum/preference/toggle/be_antag) ? "<span class='antag_enabled'>Antag Enabled</span>" : "<span class='antag_disabled'>Antag Disabled</span>"]</a>
			<br/><br/>
			<a class="menu_button" href='?src=[text_ref(src)];observe=1'>Observe</a>
		"}

		if(SSticker.current_state > GAME_STATE_PREGAME)
			splash_data += {"
				<a class="menu_button" href='?src=[text_ref(src)];view_manifest=1'>Crew Manifest</a>
				<a class="menu_button" href='?src=[text_ref(src)];character_directory=1'>Character Directory</a>
			"}

		splash_data += {"
			<a class="menu_button" href='?src=[text_ref(src)];character_setup=1'>Character Setup (<span id="character_slot">[client.prefs.read_preference(/datum/preference/name/real_name)]</span>)</a>
			<a class="menu_button" href='?src=[text_ref(src)];game_options=1'>Game Options</a>
		"}

		splash_data += "</div>"
		splash_data += {"
		<script language="JavaScript">
			var ready_int = 0;
			var ready_mark = document.getElementById("ready");
			var ready_marks = \[ "Not Ready", "<span class='cta'>Ready</span>" \];
			function toggle_ready(setReady) {
				if(setReady) {
					ready_int = setReady;
					ready_mark.innerHTML = ready_marks\[ready_int\];
				}
				else {
					ready_int++;
					if (ready_int === ready_marks.length)
						ready_int = 0;
					ready_mark.innerHTML = ready_marks\[ready_int\];
				}
			}
			var antag_int = 0;
			var antag_mark = document.getElementById("be_antag");
			var antag_marks = \[ "<span class='antag_disabled'>Antag Disabled</span> ", "<span class='antag_enabled'>Antag Enabled</span>" \];
			function toggle_antag(setAntag) {
				if(setAntag) {
					antag_int = setAntag;
					antag_mark.innerHTML = antag_marks\[antag_int\];
				}
				else {
					antag_int++;
					if (antag_int === antag_marks.length)
						antag_int = 0;
					antag_mark.innerHTML = antag_marks\[antag_int\];
				}
			}

			var character_name_slot = document.getElementById("character_slot");
			function update_current_character(name) {
				character_name_slot.textContent = name;
			}

			function append_terminal_text() {}
			function update_loading_progress() {}
		</script>
		"}

	// Tell the server this page loaded.
	splash_data += {"
		<script>
			var ready_request = new XMLHttpRequest();
			ready_request.open("GET", "?src=[text_ref(src)];title_is_ready=1", true);
			ready_request.send();
		</script>
	"}

	splash_data += "</body></html>"

	return splash_data
