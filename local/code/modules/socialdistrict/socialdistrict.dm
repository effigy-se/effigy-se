/obj/machinery/cryopod/socialdistrict
	time_till_despawn = 1 SECONDS
	latejoin_possible = FALSE
	district_transfer_enabled = TRUE
	name = "debug social district sleeper"
	desc = "oh no how did this get here i am not good with computer"

/obj/machinery/cryopod/socialdistrict/social
	name = "social district sleeper"
	district_id = "effigy_sf"
	district_name = "Social District"

/obj/machinery/cryopod/socialdistrict/action
	name = "action district sleeper"
	district_id = "effigy_sf"
	district_name = "Action District"

/obj/machinery/cryopod/proc/district_transfer(mob/living/user)
	if(!district_transfer_pending || !district_transfer_enabled)
		CRASH("district_transfer() called without a pending transfer")

	var/client/player_client = user?.client
	if(isnull(player_client))
		CRASH("could not find valid client for district transfer")

	var/target_address
	var/our_id = CONFIG_GET(string/cross_comms_name)
	var/list/servers = CONFIG_GET(keyed_list/cross_server)
	for(var/server_id in servers)
		if(server_id == our_id)
			continue
		if(server_id == district_id)
			target_address = servers[server_id]
			to_chat(world, span_green("Target district address is [target_address]."))
			break

	if(isnull(target_address))
		to_chat(world, span_danger("Could not find target address for district transfer."))
		CRASH("could not find target address for district transfer")

	district_transfer_outbound(target_district = district_id, ckey = player_client.ckey)
	player_client << link(target_address)
	to_chat(world, span_green("District transfer completed for [player_client] [user.name]."))
	district_transfer_pending = FALSE
