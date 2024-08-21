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
	var/chosenRoomNumber = tgui_input_number(target, "What number room will you be checking into?", "Room Number")
	if(!chosenRoomNumber)
		return
	if(chosenRoomNumber > SHORT_REAL_LIMIT)
		to_chat(target, span_warning("This network is only hooked up to [SHORT_REAL_LIMIT] rooms!"))
		return
	if((chosenRoomNumber < 1) || (chosenRoomNumber != round(chosenRoomNumber)))
		to_chat(target, span_warning("That is not a valid room number!"))
		return
	if(!src.Adjacent(target))
		to_chat(target, span_warning("You too far away from \the [src] to enter it!"))
	if(target.incapacitated())
		to_chat(target, span_warning("You aren't able to activate \the [src] anymore!"))

	if(chosenRoomNumber in SScondos.activeRooms)
		SScondos.enterActiveRoom(chosenRoomNumber, target)

	else
		var/datum/map_template/chosen_condo
		var/map = tgui_input_list(user, "What Condo are you checking into?","Condo Archetypes", sort_list(SScondos.condo_templates))
		if(!map)
			return
		chosen_condo = SScondos.condo_templates[map]
		SScondos.sendToNewRoom(chosenRoomNumber, chosen_condo, user, src)
