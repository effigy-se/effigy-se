/obj/machinery/cryopod/socialdistrict
	time_till_despawn = 1 SECONDS
	latejoin_possible = FALSE
	district_transfer_enabled = TRUE
	name = "debug social district sleeper"
	desc = "oh no how did this get here i am not good with computer"

/obj/machinery/cryopod/socialdistrict/social
	name = "social district sleeper"
	district_id = "effigy_dev"
	district_addr = "ss13.effigy.se:7717"
	district_name = "Social District"

/obj/machinery/cryopod/socialdistrict/action
	name = "action district sleeper"
	district_id = "effigy_dev"
	district_addr = "ss13.effigy.se:7717"
	district_name = "Action District"

/obj/machinery/cryopod/proc/district_transfer(mob/living/user)
	if(!district_transfer_pending || !district_transfer_enabled)
		CRASH("district_transfer() called without a pending transfer")

	var/client/player_client = user?.client
	if(isnull(player_client))
		CRASH("could not find valid client for district transfer")

	district_transfer_outbound(target_district = district_id, ckey = player_client.ckey)
	player_client << link("byond://[district_addr]")
	to_chat(world, span_green("District transfer completed for [player_client] [user.name]."))
	district_transfer_pending = FALSE
