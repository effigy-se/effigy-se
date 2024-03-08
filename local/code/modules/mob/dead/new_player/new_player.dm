/mob/dead/new_player/proc/set_ready_status(new_status)
	if(ready == new_status)
		return

	if(new_status != PLAYER_READY_TO_PLAY && new_status != PLAYER_NOT_READY)
		CRASH("Client [key_name(src)] attempted to set invald pre-game lobby status. Current status: [ready] Requested status: [new_status]")

	ready = new_status
	log_game("Client [key_name(src)] set pre-game lobby status to [ready ? "READY" : "NOT READY"]")
