/datum/job/cyborg/proc/effigy_cyborg_after_spawn(mob/living/silicon/robot/robot_spawn, client/player_client)
	var/list/malf_ais = list()
	var/list/regular_ais = list()
	for(var/mob/living/silicon/ai/ai_possible as anything in GLOB.ai_list)
		if(ai_possible.mind?.has_antag_datum(/datum/antagonist/malf_ai))
			malf_ais |= ai_possible
			continue
		regular_ais |= ai_possible
	var/mob/selected_ai
	if(length(malf_ais))
		selected_ai = pick(malf_ais)
	if(length(regular_ais) && !selected_ai)
		selected_ai = pick(regular_ais)
	if(selected_ai)
		robot_spawn.set_connected_ai(selected_ai)
		log_combat(selected_ai, robot_spawn, "synced cyborg [ADMIN_LOOKUP(robot_spawn)] to [ADMIN_LOOKUP(selected_ai)] (Cyborg spawn syncage)")
		if(robot_spawn.shell) //somehow?
			robot_spawn.undeploy()
			robot_spawn.notify_ai(AI_NOTIFICATION_AI_SHELL)
		else
			robot_spawn.notify_ai(TRUE)
		robot_spawn.visible_message(span_notice("[robot_spawn] gently chimes."), span_notice("LawSync protocol engaged."))
		robot_spawn.lawsync()
		robot_spawn.lawupdate = TRUE
		robot_spawn.show_laws()
