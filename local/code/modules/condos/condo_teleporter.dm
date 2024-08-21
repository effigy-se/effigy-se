// Essentially a rewritten version of Hilbert's Hotel that supports multiple map templates; and a reference to GMTower's beautiful condo system. You should play it's successor... :3
/obj/machinery/interlink_condo_teleporter
	name = "Matrixed Teleportation Unit"
	desc = "A sub-divided; stable teleportation system with a unseen central processing hub."
	icon = /obj/machinery/teleport/hub::icon
	icon_state = /obj/machinery/teleport/hub::icon_state
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/machinery/interlink_condo_teleporter/examine(mob/user)
	. = ..()
	. += span_notice("You can use this to retire to a private room.")
	. += span_warning("Beware: once all occupants exit a room; it resets.")

// Shouldn't happen naturally; but just in case.
/obj/machinery/interlink_condo_teleporter/Destroy()
	// ejectRooms()
	return ..()

/obj/machinery/interlink_condo_teleporter/attack_robot(mob/user)
	if(user.Adjacent(src))
		promptAndCheckIn(user, user)
	return TRUE

/obj/machinery/interlink_condo_teleporter/attack_hand(mob/living/user, list/modifiers)
	promptAndCheckIn(user, user)
	return TRUE

/obj/machinery/interlink_condo_teleporter/attack_tk(mob/user)
	to_chat(user, span_notice("\The [src] actively rejects your mind as the bluespace energies surrounding it disrupt your telekinesis."))
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/machinery/interlink_condo_teleporter/proc/promptAndCheckIn(mob/user, mob/target)
	var/requested_condo = tgui_input_number(target, "What number room will you be checking into?", "Room Number", 1, min_value = 1)
	if(!requested_condo)
		return
	if(requested_condo > CONDO_LIMIT)
		to_chat(target, span_warning("This network is only hooked up to [CONDO_LIMIT] rooms!"))
		return
	if((requested_condo < 1) || (requested_condo != round(requested_condo)))
		to_chat(target, span_warning("That is not a valid room number!"))
		return
	if(!src.Adjacent(target))
		to_chat(target, span_warning("You too far away from \the [src] to enter it!"))
		return
	if(target.incapacitated())
		to_chat(target, span_warning("You aren't able to activate \the [src] anymore!"))
		return

	if(SScondos.active_condos["[requested_condo]"])
		SScondos.enter_active_room(requested_condo, target)

	else
		to_chat(world, span_yellowteamradio("CONDO: Room [requested_condo] not found. Trying to create."))
		var/datum/map_template/chosen_condo
		var/map = tgui_input_list(user, "What Condo are you checking into?","Condo Archetypes", sort_list(SScondos.condo_templates))
		if(!map)
			return
		chosen_condo = SScondos.condo_templates[map]
		SScondos.create_and_enter_condo(requested_condo, chosen_condo, user, src)
