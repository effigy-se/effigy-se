/datum/job/ai/proc/effigy_ai_after_spawn(mob/living/silicon/ai/ai_spawn, client/player_client)
	// Sync Borgs
	for(var/mob/living/silicon/robot/sync_target in GLOB.silicon_mobs)
		if(!(sync_target.z in SSmapping.levels_by_trait(ZTRAIT_STATION)) || (sync_target.z in SSmapping.levels_by_trait(ZTRAIT_ICE_RUINS_UNDERGROUND))) // Skip ghost cafe, interlink, and other cyborgs.
			continue
		if(sync_target.emagged) // Skip emagged cyborgs, they don't sync up to the AI anyways and emagged borgs are already outed by just looking at a robotics console.
			continue
		if(sync_target.connected_ai)
			continue
		sync_target.notify_ai(AI_NOTIFICATION_CYBORG_DISCONNECTED)
		sync_target.set_connected_ai(ai_spawn)
		log_combat(ai_spawn, sync_target, "synced cyborg [ADMIN_LOOKUP(sync_target)] to [ADMIN_LOOKUP(ai_spawn)] (AI spawn syncage)")
		if(sync_target.shell)
			sync_target.undeploy()
			sync_target.notify_ai(AI_NOTIFICATION_AI_SHELL)
		else
			sync_target.notify_ai(TRUE)
		sync_target.visible_message(span_notice("[sync_target] gently chimes."), span_notice("LawSync protocol engaged."))
		log_combat(ai_spawn, sync_target, "forcibly synced cyborg laws via spawning in")
		sync_target.lawsync()
		sync_target.lawupdate = TRUE
		sync_target.show_laws()
