/*
	LOBBY CONVOS
*/

/datum/controller/subsystem/slashco/proc/find_valid_lobby_convo_targets()
	for(var/connection in GLOB.player_list)
		var/mob/player_mob = connection
		var/client/player_client = player_mob.client
		if(player_client.prefs.read_preference(/datum/preference/toggle/sound_lobby))
			addtimer(CALLBACK(src, PROC_REF(send_lobby_convo)), 15 SECONDS)
			send_lobby_convo(player_mob)

/datum/controller/subsystem/slashco/proc/send_lobby_convo(mob/our_target)
	if(prob(25)) // Not all too common but not rare either
		var/our_picked_convo = pick(typesof(/datum/lobby_conversation))
		play_lobby_convo(our_target, our_convo = our_picked_convo)

/datum/controller/subsystem/slashco/proc/play_lobby_convo(mob/our_target, var/phase = 1, datum/lobby_conversation/our_convo)
	if(our_convo && our_target)
		var/sound = /datum/lobby_conversation::sound_1
		var/length = /datum/lobby_conversation::sound_1_length
		switch(phase)
			if(1)
				sound = our_convo.sound_1
				length = our_convo.sound_1_length
			if(2)
				sound = our_convo.sound_2
				length = our_convo.sound_2_length
			if(3)
				sound = our_convo.sound_3
		our_target?.playsound_local(get_turf(our_target), sound, 75, FALSE) // possible the game is early started
		if(phase == 3)
			return
		phase++
		if(our_target) // are you still there?
			addtimer(CALLBACK(src, PROC_REF(play_lobby_convo), our_target, phase, our_convo), length)

/// DATUMS PAST HERE

/// Big Boobs / Base Type
/datum/lobby_conversation
	var/sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/bigboobs/1.ogg'
	var/sound_1_length = 2 SECONDS
	var/sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/bigboobs/2.ogg'
	var/sound_2_length = 2 SECONDS
	var/sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/bigboobs/3.ogg'

/// Abomignat
/datum/lobby_conversation/abomignat
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/abomignat/1.ogg'
	sound_1_length = 5 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/abomignat/2.ogg'
	sound_2_length = 3 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/abomignat/3.ogg'

/// Alternate Hyena
/datum/lobby_conversation/alternatehyena
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/alternatehyena/1.ogg'
	sound_1_length = 14 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/alternatehyena/2.ogg'
	sound_2_length = 2 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/alternatehyena/3.ogg'

/// Amogus (Caked Up)
/datum/lobby_conversation/amoguscaked
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/amoguscaked/1.ogg'
	sound_1_length = 4 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/amoguscaked/2.ogg'
	sound_2_length = 2 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/amoguscaked/3.ogg'

/// Ass Smack
/datum/lobby_conversation/asssmack
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/asssmack/1.ogg'
	sound_1_length = 6 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/asssmack/2.ogg'
	sound_2_length = 2 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/asssmack/3.ogg'

/// Average Discord User
/datum/lobby_conversation/avgdiscorduser
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/avgdiscorduser/1.ogg'
	sound_1_length = 3 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/avgdiscorduser/2.ogg'
	sound_2_length = 2 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/avgdiscorduser/3.ogg'

/// Bootycheeks
/datum/lobby_conversation/bootycheeks
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/bootycheeks/1.ogg'
	sound_1_length = 11 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/bootycheeks/2.ogg'
	sound_2_length = 1 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/bootycheeks/3.ogg'

/// Borgmire
/datum/lobby_conversation/borgmire
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/borgmire/1.ogg'
	sound_1_length = 12 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/borgmire/2.ogg'
	sound_2_length = 2 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/borgmire/3.ogg'

/// Distraction
/datum/lobby_conversation/distraction
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/distraction/1.ogg'
	sound_1_length = 5 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/distraction/2.ogg'
	sound_2_length = 5 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/distraction/3.ogg'

/// Elevator Smells
/datum/lobby_conversation/elevator_smells
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/elevatorsmells/1.ogg'
	sound_1_length = 3 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/elevatorsmells/2.ogg'
	sound_2_length = 4 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/elevatorsmells/3.ogg'

/// Femling (this is the one we actually have a reference to baked into the base codebase!)
/datum/lobby_conversation/femling
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/femling/1.ogg'
	sound_1_length = 7 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/femling/2.ogg'
	sound_2_length = 6 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/femling/3.ogg'

/// Gameplan
/datum/lobby_conversation/gameplan
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/gameplan/1.ogg'
	sound_1_length = 2 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/gameplan/2.ogg'
	sound_2_length = 4 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/gameplan/3.ogg'

/// Penis
/datum/lobby_conversation/penis
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/penis/1.ogg'
	sound_1_length = 2 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/penis/2.ogg'
	sound_2_length = 2 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/penis/3.ogg'

/// Power Recovery
/datum/lobby_conversation/powerrecovery
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/powerrecovery/1.ogg'
	sound_1_length = 5 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/powerrecovery/2.ogg'
	sound_2_length = 11 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/powerrecovery/3.ogg'

/// Rumpshaker
/datum/lobby_conversation/rumpshaker
	sound_1 = 'local/code/modules/slashco13/sound/lobbyconvos/rumpshaker/1.ogg'
	sound_1_length = 2 SECONDS
	sound_2 = 'local/code/modules/slashco13/sound/lobbyconvos/rumpshaker/2.ogg'
	sound_2_length = 2 SECONDS
	sound_3 = 'local/code/modules/slashco13/sound/lobbyconvos/rumpshaker/3.ogg'
