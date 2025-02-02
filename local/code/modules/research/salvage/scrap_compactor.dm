/obj/machinery/scrap_compactor
	name = "scrap compactor"
	desc = "Compacts less useful scrap into more useful items at a roughly equivalent rate to it's market rate."
	icon = 'local/icons/obj/machines/scrap_compactor.dmi'
	icon_state = "compactor"
	anchored = TRUE
	density = TRUE
	circuit = /obj/item/circuitboard/machine/scrap_compactor
	/// How much scrap value do we have banked?
	var/banked_value = 0
	/// Our maximum scrap value?
	var/maximum_value = 500

/obj/machinery/scrap_compactor/examine(mob/user)
	. = ..()
	. += span_notice("<br>[banked_value]/[maximum_value] points available.")

/obj/machinery/scrap_compactor/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	. = ..()
	if(istype(tool, /obj/item/scrap))
		var/obj/item/scrap/found_scrap = tool
		found_scrap.moveToNullspace()
		balloon_alert(user, "scrap inserted!")
		banked_value += found_scrap.credit_cost
		if(banked_value > maximum_value)
			banked_value = maximum_value
		qdel(found_scrap)
		return ITEM_INTERACT_SUCCESS
	return ITEM_INTERACT_BLOCKING

/obj/machinery/scrap_compactor/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	var/choice = tgui_input_list(user, "Pick Your Reward:", "Scrap Compaction", list("BEPIS Tech (100)", "Tier 5 Part (250)",))
	if(!choice)
		return

	switch(choice)
		if("BEPIS TECH (100)")
			if(banked_value < 100)
				balloon_alert(user, "not enough points")
				return
			banked_value -= 100
			var/our_disk = /obj/item/disk/design_disk/bepis/remove_tech // this fucking rots. literally only way this works for whatever fucking reason
			new our_disk(get_turf(src))
			playsound(loc, 'sound/machines/click.ogg', 15, TRUE, -3)
		if("Tier 5 Part (250)")
			if(banked_value < 250)
				balloon_alert(user, "not enough points")
				return
			banked_value -= 250
			var/picked_part = pick(/obj/item/stock_parts/capacitor/experimental, /obj/item/stock_parts/scanning_module/prototype, /obj/item/stock_parts/servo/atomic, /obj/item/stock_parts/micro_laser/quintuple_bound, /obj/item/stock_parts/matter_bin/anomic)
			new picked_part(get_turf(src))
			playsound(loc, 'sound/machines/click.ogg', 15, TRUE, -3)

/obj/machinery/scrap_compactor/attack_robot(mob/user)
	return attack_hand(user)

/obj/machinery/scrap_compactor/attack_ai(mob/user)
	return attack_hand(user)

/obj/machinery/scrap_compactor/screwdriver_act(mob/user, obj/item/tool)
	return default_deconstruction_screwdriver(user, "compactor-open", "compactor", tool)

/obj/machinery/scrap_compactor/crowbar_act(mob/user, obj/item/tool)
	return default_deconstruction_crowbar(tool)
