//Credit to Beestation for the original anesthetic machine code: https://github.com/BeeStation/BeeStation-Hornet/pull/3753

/obj/machinery/breath_machine
	name = "portable breath machine"
	desc = "A stand on wheels with a digital regulator, similar to an IV drip, that can hold a canister of gas along with a gas mask.<br>Is it N2 for humans and N2O for vox again? Other way? What's O2? I'm not the doctor here."
	icon = 'local/icons/obj/medical/breath_machine.dmi'
	icon_state = "breath_machine"
	anchored = FALSE
	mouse_drag_pointer = MOUSE_ACTIVE_POINTER
	use_power = NO_POWER_USE
	/// The mask attached to the anesthetic machine
	var/obj/item/clothing/mask/breath/retractable/attached_mask
	/// the tank attached to the anesthetic machine. Use a subtype to be preloaded.
	var/obj/item/tank/attached_tank = null
	/// Is the attached mask currently out?
	var/mask_out = FALSE

/obj/machinery/breath_machine/n2o
	attached_tank = new /obj/item/tank/internals/anesthetic

/obj/structure/closet/secure_closet/medical2/Initialize(mapload)
	. = ..()
	new /obj/machinery/breath_machine/n2o(loc)
	qdel(src)

/obj/machinery/breath_machine/examine(mob/user)
	. = ..()

	. += "<b>Right-clicking</b> with a wrench will deconstruct the stand, if there is no tank attached."
	if(mask_out)
		. += "<b>Click</b> on the stand to retract the mask, if the mask is currently out"
	if(attached_tank)
		. += "<b>Alt + Click</b> to remove [attached_tank]."

/obj/machinery/breath_machine/Initialize(mapload)
	. = ..()
	attached_mask = new /obj/item/clothing/mask/breath/retractable(src)
	attached_mask.attached_machine = src
	update_icon()

/obj/machinery/breath_machine/wrench_act_secondary(mob/living/user, obj/item/tool)
	if(user.combat_mode)
		return ..()

	if(mask_out)
		to_chat(user, span_warning("There is someone currently attached to the [src]!"))
		return TRUE

	if(attached_tank)
		to_chat(user, span_warning("[attached_tank] inside of the [src] deconstruction."))
		return TRUE

	new /obj/item/breath_machine_kit(get_turf(src))
	tool.play_tool_sound(user)
	to_chat(user, span_notice("You deconstruct the [src]."))
	qdel(src)
	return TRUE

/obj/machinery/breath_machine/update_icon()
	. = ..()

	cut_overlays()

	if(attached_tank)
		add_overlay("tank_on")

	if(mask_out)
		add_overlay("mask_off")
		return
	add_overlay("mask_on")

/obj/machinery/breath_machine/attack_hand(mob/living/user)
	. = ..()
	if(!retract_mask())
		return FALSE
	visible_message(span_notice("[user] retracts [attached_mask] back into [src]."))

/obj/machinery/breath_machine/attacked_by(obj/item/used_item, mob/living/user)
	if(!istype(used_item, /obj/item/tank))
		return ..()

	if(attached_tank) // If there is an attached tank, remove it and drop it on the floor
		attached_tank.forceMove(loc)

	used_item.forceMove(src) // Put new tank in, set it as attached tank
	visible_message(span_notice("[user] inserts [used_item] into [src]."))
	attached_tank = used_item
	update_icon()

/obj/machinery/breath_machine/click_alt(mob/user)
	if(!attached_tank)
		return

	attached_tank.forceMove(loc)
	to_chat(user, span_notice("You remove the [attached_tank]."))
	attached_tank = null
	update_icon()
	if(mask_out)
		retract_mask()

///Retracts the attached_mask back into the machine
/obj/machinery/breath_machine/proc/retract_mask()
	if(!mask_out)
		return FALSE

	if(iscarbon(attached_mask.loc)) // If mask is on a mob
		var/mob/living/carbon/attached_mob = attached_mask.loc
		// Close external air tank
		if (attached_mob.external)
			attached_mob.close_externals()
		attached_mob.transferItemToLoc(attached_mask, src, TRUE)
	else
		attached_mask.forceMove(src)

	mask_out = FALSE
	update_icon()
	return TRUE

/obj/machinery/breath_machine/mouse_drop_dragged(mob/living/carbon/over, mob/user, src_location, over_location, params)
	. = ..()
	if(!istype(over))
		return

	if((!Adjacent(over)) || !(user.Adjacent(over)))
		return FALSE

	if(!attached_tank || mask_out)
		to_chat(user, span_warning("[mask_out ? "The machine is already in use!" : "The machine has no attached tank!"]"))
		return FALSE

	// if we somehow lost the mask, let's just make a brand new one. the wonders of technology!
	if(QDELETED(attached_mask))
		attached_mask = new /obj/item/clothing/mask/breath/retractable(src)
		update_icon()

	user.visible_message(span_warning("[user] attemps to attach the [attached_mask] to [over]."), span_notice("You attempt to attach the [attached_mask] to [over]"))
	if(!do_after(user, 5 SECONDS, over))
		return
	if(!over.equip_to_appropriate_slot(attached_mask))
		to_chat(user, span_warning("You are unable to attach the [attached_mask] to [over]!"))
		return

	user.visible_message(span_warning("[user] attaches the [attached_mask] to [over]."), span_notice("You attach the [attached_mask] to [over]"))

	// Open the tank externally
	over.open_internals(attached_tank, is_external = TRUE)
	mask_out = TRUE
	START_PROCESSING(SSmachines, src)
	update_icon()

/obj/machinery/breath_machine/process()
	if(!mask_out) // If not on someone, stop processing
		return PROCESS_KILL

	var/mob/living/carbon/carbon_target = attached_mask.loc
	if(get_dist(src, get_turf(attached_mask)) > 1) // If too far away, detach
		to_chat(carbon_target, span_warning("[attached_mask] is ripped off of your face!"))
		retract_mask()
		return PROCESS_KILL

	// Attempt to restart airflow if it was temporarily interrupted after mask adjustment.
	if(attached_tank && istype(carbon_target) && !carbon_target.external && !attached_mask.up)
		carbon_target.open_internals(attached_tank, is_external = TRUE)

/obj/machinery/breath_machine/Destroy()
	if(mask_out)
		retract_mask()

	if(attached_tank)
		attached_tank.forceMove(loc)
		attached_tank = null

	QDEL_NULL(attached_mask)
	. = ..()

/// This a special version of the breath mask used for the breath machine.
/obj/item/clothing/mask/breath/retractable
	/// What machine is the mask currently attached to?
	var/datum/weakref/attached_machine

/obj/item/clothing/mask/breath/retractable/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, ABSTRACT_ITEM_TRAIT)

/obj/item/clothing/mask/breath/retractable/Destroy()
	attached_machine = null
	return ..()

/obj/item/clothing/mask/breath/retractable/dropped(mob/user)
	. = ..()

	if(loc != attached_machine) //If it isn't in the machine, then it retracts when dropped
		to_chat(user, span_notice("[src] retracts back into the [attached_machine]."))

		if(!istype(attached_machine, /obj/machinery/breath_machine))
			qdel(src)
			return FALSE

		var/obj/machinery/breath_machine/source_machine = attached_machine
		source_machine.retract_mask()

/obj/item/clothing/mask/breath/retractable/adjust_visor(mob/living/carbon/user)
	. = ..()
	// Air only goes through the mask, so temporarily pause airflow if mask is getting adjusted.
	// Since the mask is NODROP, the only possible user is the wearer
	var/mob/living/carbon/carbon_target = loc
	if(up && carbon_target.external)
		carbon_target.close_externals()

/// A boxed version of the Anesthetic Machine. This is what is printed from the medical prolathe.
/obj/item/breath_machine_kit
	name = "breath machine parts kit"
	desc = "Contains all of the parts needed to assemble a portable breath machine. Use in hand to construct."
	w_class = WEIGHT_CLASS_BULKY
	icon = 'icons/obj/storage/box.dmi'
	icon_state = "plasticbox"

/obj/item/breath_machine_kit/attack_self(mob/user)
	new /obj/machinery/breath_machine(user.loc)

	playsound(get_turf(user), 'sound/weapons/circsawhit.ogg', 50, TRUE)
	qdel(src)
