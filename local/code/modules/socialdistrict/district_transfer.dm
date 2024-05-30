/datum/world_topic/district_transfer
	keyword = "district_transfer"
	require_comms_key = TRUE

/datum/world_topic/district_transfer/Run(list/data)
	if(isnull(data))
		to_chat(world, span_warning("District transfer error: input data is null"))
		return

	var/list/input = data["input"]
	to_chat(world, span_warning("District transfer incoming from [input["source"]]: [input["ckey"]]"))

/proc/district_transfer_outbound(target_district, ckey, character)
	var/our_id = CONFIG_GET(string/cross_comms_name)
	var/message_id = "district_transfer_inbound"
	send2otherserver(source = our_id, msg = message_id, type = "district_transfer", target_servers = list(target_district), additional_data = list("ckey" = ckey))
