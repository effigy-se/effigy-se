#define CLOCK_IN_COOLDOWN 15 MINUTES

/obj/machinery/time_clock
	name = "time clock"
	desc = "Allows employees to clock in and out of their jobs"
	icon = 'local/icons/obj/machines/time_clock.dmi'
	icon_state = "timeclock"
	density = FALSE

	///What ID card is currently inside?
	var/obj/item/card/id/inserted_id
	///What trim is applied to inserted IDs?
	var/target_trim = /datum/id_trim/job/assistant

	//These variables are the same as the ones that the cryopods use to make annoucements
	///The radio that is used to announce when someone clocks in and clocks out.
	var/obj/item/radio/headset/radio = /obj/item/radio/headset/silicon/pai
	///The channel that the radio broadcasts on.
	var/announcement_channel = null
	/// What alert level do we need to start preforming job checks at?
	var/job_check_alert_level = SEC_LEVEL_RED

MAPPING_DIRECTIONAL_HELPERS(/obj/machinery/time_clock, 28)

/obj/machinery/time_clock/Initialize(mapload)
	. = ..()
	radio = new radio(src)

/obj/machinery/time_clock/Destroy()
	. = ..()
	if(inserted_id)
		inserted_id.forceMove(drop_location())

	if(radio)
		QDEL_NULL(radio)

/obj/machinery/time_clock/update_overlays()
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		return FALSE

	if(!inserted_id)
		. += "[icon_state]_r_idle"
		. += "[icon_state]_l_idle"

	else
		. += "[icon_state]_r_card"
		. += "[icon_state]_l_card"

/obj/machinery/time_clock/attackby(obj/item/used_item, mob/user)
	if(!istype(used_item, /obj/item/card/id))
		return ..()

	if(inserted_id)
		to_chat(user, span_warning("There is already an ID card present!"))
		return FALSE

	if(!user.transferItemToLoc(used_item))
		to_chat(user, span_warning("You are unable to put [used_item] inside of the [src]!"))
		return FALSE

	inserted_id = used_item
	update_appearance()
	update_static_data_for_all_viewers()
	to_chat(user, span_boldwarning("Before clocking out, please return any piece of job gear that is important or limited to your workplace."))

	if(important_job_check())
		if(SSsecurity_level.get_current_level_as_number() >= job_check_alert_level)
			to_chat(user, span_boldwarning("You are unable to clock out at the current alert level."))
			eject_inserted_id(user)
			return FALSE

		if(tgui_alert(user, "You are a member of security and/or command, make sure that you ahelp before clocking out. If you decide to clock back in later, you will need to go to the Head of Personnel. Do you wish to continue?", "[src]", list("Yes", "No")) != "Yes")
			eject_inserted_id(user)
			return FALSE

	playsound(src, 'sound/machines/terminal_insert_disc.ogg', 50, FALSE)
	return TRUE

/*
/obj/machinery/time_clock/click_alt(mob/user)
	if(!eject_inserted_id(user))
		return CLICK_ACTION_BLOCKING

	return CLICK_ACTION_SUCCESS
*/

/obj/machinery/time_clock/AltClick(mob/user)
	. = ..()
	if(!Adjacent(user))
		to_chat(user, span_warning("You are out of range of the [src]!"))
		return FALSE
	if(!eject_inserted_id(user))
		return FALSE

///Ejects the ID stored inside of the parent machine, if there is one.
/obj/machinery/time_clock/proc/eject_inserted_id(mob/recepient)
	if(!inserted_id || !recepient)
		return FALSE

	inserted_id.forceMove(drop_location())
	recepient.put_in_hands(inserted_id)

	inserted_id = FALSE
	update_appearance()
	update_static_data_for_all_viewers()
	playsound(src, 'sound/machines/terminal_eject.ogg', 50, FALSE)

	return TRUE

///Clocks out the currently inserted ID Card
/obj/machinery/time_clock/proc/clock_out()
	if(!inserted_id)
		return FALSE

	var/datum/component/off_duty_timer/timer_component = inserted_id.AddComponent(/datum/component/off_duty_timer, CLOCK_IN_COOLDOWN)
	if(important_job_check())
		timer_component.hop_locked = TRUE
		log_admin("[inserted_id.registered_name] clocked out as a head of staff and/or command")

	var/current_assignment = inserted_id.assignment
	var/datum/id_trim/job/current_trim = inserted_id.trim
	var/datum/job/clocked_out_job = current_trim.job
	SSjob.FreeRole(clocked_out_job.title)
	radio.talk_into(src, "[inserted_id.registered_name], [current_assignment] has gone off-duty.", announcement_channel)
	update_static_data_for_all_viewers()

	SSid_access.apply_trim_to_card(inserted_id, target_trim, TRUE)
	inserted_id.assignment = "Off-Duty " + current_assignment
	inserted_id.update_label()

	GLOB.manifest.modify(inserted_id.registered_name, inserted_id.assignment, inserted_id.get_trim_assignment())
	return TRUE

///Clocks the currently inserted ID Card back in
/obj/machinery/time_clock/proc/clock_in()
	if(!inserted_id)
		return FALSE

	if(id_cooldown_check())
		return FALSE

	var/datum/component/off_duty_timer/id_component = inserted_id.GetComponent(/datum/component/off_duty_timer)
	if(!id_component)
		return FALSE

	var/datum/job/clocked_in_job = id_component.stored_trim.job
	if(!SSjob.OccupyRole(clocked_in_job.title))
		say("[capitalize(clocked_in_job.title)] has no free slots available, unable to clock in!")
		return FALSE


	SSid_access.apply_trim_to_card(inserted_id, id_component.stored_trim.type, TRUE)
	inserted_id.assignment = id_component.stored_assignment

	radio.talk_into(src, "[inserted_id.registered_name], [inserted_id.assignment] has returned to duty.", announcement_channel)
	GLOB.manifest.modify(inserted_id.registered_name, inserted_id.assignment, inserted_id.get_trim_assignment())

	qdel(id_component)
	inserted_id.update_label()
	update_static_data_for_all_viewers()

	return TRUE

///Is the job of the inserted ID being worked by a job that in an important department? If so, this proc will return TRUE.
/obj/machinery/time_clock/proc/important_job_check()
	if(!inserted_id)
		return FALSE

	var/datum/id_trim/job/current_trim = inserted_id.trim
	var/datum/job/clocked_in_job = current_trim.job
	if((/datum/job_department/command in clocked_in_job.departments_list) || (/datum/job_department/security in clocked_in_job.departments_list))
		return TRUE

	return FALSE

///Is the inserted ID on cooldown? returns TRUE if the ID has a cooldown
/obj/machinery/time_clock/proc/id_cooldown_check()
	if(!inserted_id)
		return FALSE

	var/datum/component/off_duty_timer/id_component = inserted_id.GetComponent(/datum/component/off_duty_timer)
	if(!id_component)
		return FALSE

	if(id_component.hop_locked)
		return TRUE

	if(!id_component.on_cooldown)
		return FALSE

	return TRUE

///Is the inserted ID off-duty? Returns true if the ID is off-duty
/obj/machinery/time_clock/proc/off_duty_check()
	if(!inserted_id)
		return FALSE

	var/datum/component/off_duty_timer/id_component = inserted_id.GetComponent(/datum/component/off_duty_timer)
	if(!id_component)
		return FALSE

	return TRUE

///What items do we want to remove from the person clocking out?
#define TIME_CLOCK_RETURN_ITEMS list( \
	/obj/item/melee/baton/security, \
	/obj/item/melee/baton/security/loaded, \
	/obj/item/melee/baton/telescopic, \
	/obj/item/melee/baton, \
	/obj/item/assembly/flash/handheld, \
	/obj/item/gun/energy/disabler, \
	/obj/item/megaphone/command, \
	/obj/item/door_remote/captain, \
	/obj/item/door_remote/chief_engineer, \
	/obj/item/door_remote/research_director, \
	/obj/item/door_remote/head_of_security, \
	/obj/item/door_remote/quartermaster, \
	/obj/item/door_remote/chief_medical_officer, \
	/obj/item/door_remote/civilian, \
	/obj/item/circuitboard/machine/techfab/department/engineering, \
	/obj/item/circuitboard/machine/techfab/department/service, \
	/obj/item/circuitboard/machine/techfab/department/security, \
	/obj/item/circuitboard/machine/techfab/department/medical, \
	/obj/item/circuitboard/machine/techfab/department/cargo, \
	/obj/item/circuitboard/machine/techfab/department/science, \
	/obj/item/pipe_dispenser/bluespace, \
	/obj/item/mod/control/pre_equipped/advanced, \
	/obj/item/clothing/shoes/magboots/advance, \
	/obj/item/shield/riot/tele, \
	/obj/item/storage/belt/security/full, \
	/obj/item/gun/energy/e_gun/hos, \
	/obj/item/pinpointer/nuke, \
	/obj/item/gun/energy/e_gun, \
	/obj/item/storage/belt/sabre, \
	/obj/item/mod/control/pre_equipped/magnate, \
	/obj/item/clothing/suit/armor/vest/warden, \
	/obj/item/clothing/glasses/hud/security/sunglasses, \
	/obj/item/clothing/gloves/krav_maga/sec, \
	/obj/item/clothing/suit/armor/vest/alt/sec, \
	/obj/item/storage/belt/holster/detective/full, \
	/obj/item/reagent_containers/spray/pepper, \
	/obj/item/detective_scanner, \
	/obj/item/gun/ballistic/revolver/c38/detective, \
	/obj/item/mod/control/pre_equipped/security, \
	/obj/item/mod/control/pre_equipped/safeguard, \
	/obj/item/defibrillator/compact/loaded, \
	/obj/item/mod/control/pre_equipped/rescue, \
	/obj/item/card/id/departmental_budget/car, \
	/obj/item/clothing/suit/armor/reactive/teleport, \
	/obj/item/mod/control/pre_equipped/research, \
)


/obj/machinery/time_clock/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	if(machine_stat & (NOPOWER|BROKEN))
		return

	add_fingerprint(user)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "TimeClock", name)
		ui.open()


/obj/machinery/time_clock/ui_state(mob/user)
	return GLOB.conscious_state

/obj/machinery/time_clock/ui_static_data(mob/user)
	var/data = list()
	data["inserted_id"] = inserted_id
	data["station_alert_level"] = SSsecurity_level.get_current_level_as_text()
	data["clock_status"] = off_duty_check()

	if(inserted_id)
		data["id_holder_name"] = inserted_id.registered_name
		data["id_job_title"] = inserted_id.assignment

	return data

/obj/machinery/time_clock/ui_data(mob/user)
	var/data = list()
	data["current_time"] = station_time_timestamp()

	if(inserted_id)
		data["insert_id_cooldown"] = id_cooldown_check()

	return data

/obj/machinery/time_clock/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("clock_in_or_out")
			if(off_duty_check())
				if(!(clock_in()))
					return
				log_admin("[key_name(usr)] clocked in as \an [inserted_id.assignment].")

				var/datum/mind/user_mind = usr.mind
				if(user_mind)
					user_mind.clocked_out_of_job = FALSE

			else
				log_admin("[key_name(usr)] clocked out as \an [inserted_id.assignment].")
				clock_out()
				var/mob/living/carbon/human/human_user = usr
				if(human_user)
					human_user.return_items_to_console(TIME_CLOCK_RETURN_ITEMS)

				var/datum/mind/user_mind = usr.mind
				if(user_mind)
					user_mind.clocked_out_of_job = TRUE

				if(important_job_check())
					message_admins("[key_name(usr)] has clocked out as a head of staff. [ADMIN_JMP(src)]")

			playsound(src, 'sound/machines/ping.ogg', 50, FALSE)

		if("eject_id")
			eject_inserted_id(usr)

#undef TIME_CLOCK_RETURN_ITEMS

/obj/item/wallframe/time_clock
	name = "time clock frame"
	desc = "Contains all of the parts needed to assemble a wall-mounted time clock"
	icon_state = "unanchoredstatusdisplay"
	result_path = /obj/machinery/time_clock
	pixel_shift = 28
	custom_materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT,
		/datum/material/glass = SHEET_MATERIAL_AMOUNT * 2,
	)

#undef CLOCK_IN_COOLDOWN
