#define HYPO_INJECT 1
#define HYPO_SPRAY 0

#define WAIT_INJECT 2 SECONDS
#define WAIT_SPRAY 1.5 SECONDS
#define SELF_INJECT 1.5 SECONDS
#define SELF_SPRAY 1.5 SECONDS

#define DELUXE_WAIT_INJECT 0.5 SECONDS
#define DELUXE_WAIT_SPRAY 0
#define DELUXE_SELF_INJECT 1 SECONDS
#define DELUXE_SELF_SPRAY 1 SECONDS

#define COMBAT_WAIT_INJECT 0
#define COMBAT_WAIT_SPRAY 0
#define COMBAT_SELF_INJECT 0
#define COMBAT_SELF_SPRAY 0

/obj/item/hypospray/mkii
	name = "hypospray Mk.II"
	icon_state = "hypo2"
	icon = 'local/icons/obj/medical/hyposprays.dmi'
	greyscale_config = /datum/greyscale_config/hypospray_mkii
	desc = "A new development from DeForest Medical, this hypospray takes 50-unit vials as the drug supply for easy swapping."
	w_class = WEIGHT_CLASS_TINY
	var/list/allowed_containers = list(/obj/item/reagent_containers/cup/hypovial/small)
	/// The presently-inserted vial.
	var/obj/item/reagent_containers/cup/hypovial/vial
	/// If the Hypospray starts with a vial, which vial does it start with?
	var/obj/item/reagent_containers/cup/hypovial/start_vial

	/// Time taken to inject others
	var/inject_wait = WAIT_INJECT
	/// Time taken to spray others
	var/spray_wait = WAIT_SPRAY
	/// Time taken to inject self
	var/inject_self = SELF_INJECT
	/// Time taken to spray self
	var/spray_self = SELF_SPRAY

	/// Can you hotswap vials? - now all hyposprays can!
	var/quickload = TRUE
	/// Does it penetrate clothing?
	var/penetrates = null
	/// Used for GAGS-ified hypos.
	var/gags_bodystate = "hypo2_normal"

/obj/item/hypospray/mkii/piercing
	name = "hypospray Mk.II advanced"
	allowed_containers = list(/obj/item/reagent_containers/cup/hypovial/small)
	icon_state = "piercinghypo2"
	gags_bodystate = "hypo2_piercing"
	desc = "The advanced variant in the DeForest Hypospray Mk. II series, able to pierce through thick armor and quickly inject the chemicals."
	inject_wait = DELUXE_WAIT_INJECT
	spray_wait = DELUXE_WAIT_SPRAY
	spray_self = DELUXE_SELF_INJECT
	inject_self = DELUXE_SELF_SPRAY
	penetrates = INJECT_CHECK_PENETRATE_THICK

/obj/item/hypospray/mkii/piercing/atropine
	start_vial = /obj/item/reagent_containers/cup/hypovial/small/atropine

/obj/item/hypospray/mkii/deluxe
	name = "hypospray Mk.II deluxe"
	icon_state = "bighypo2"
	gags_bodystate = "hypo2_deluxe"
	desc = "The deluxe variant of the Hypospray Mk. II, able to take both 100u and 50u vials."
	allowed_containers = list(/obj/item/reagent_containers/cup/hypovial/small, /obj/item/reagent_containers/cup/hypovial/large)

/obj/item/hypospray/mkii/deluxe/cmo
	name = "hypospray Mk.II deluxe: CMO edition"
	icon_state = "cmo2"
	gags_bodystate = "hypo2_cmo"
	desc = "The CMO's prized Hypospray Mk. II Deluxe, able to take both 100u and 50u vials, acting faster and able to deliver more reagents per spray."
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	inject_wait = DELUXE_WAIT_INJECT
	spray_wait = DELUXE_WAIT_SPRAY
	spray_self = DELUXE_SELF_SPRAY
	inject_self = DELUXE_SELF_INJECT
	penetrates = INJECT_CHECK_PENETRATE_THICK

/obj/item/hypospray/mkii/deluxe/cmo/combat
	name = "hypospray Mk.II deluxe: combat edition"
	icon_state = "combat2"
	gags_bodystate = "hypo2_tactical"
	desc = "A variant of the Hypospray Mk. II Deluxe, able to take both 100u and 50u vials, with overcharged applicators and an armor-piercing tip."
	// Made non-indestructible since this is typically an admin spawn.  still robust though!
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	inject_wait = COMBAT_WAIT_INJECT
	spray_wait = COMBAT_WAIT_SPRAY
	spray_self = COMBAT_SELF_INJECT
	inject_self = COMBAT_SELF_SPRAY
	penetrates = INJECT_CHECK_PENETRATE_THICK

/obj/item/hypospray/mkii/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	if(!isnull(start_vial))
		vial = new start_vial
		update_appearance()

/obj/item/hypospray/mkii/update_overlays()
	. = ..()
	if(!vial)
		return
	if(vial.reagents.total_volume)
		var/vial_spritetype = "chem-color"
		if(istype(vial, /obj/item/reagent_containers/cup/hypovial/large))
			vial_spritetype += "[vial.type_suffix]"
		else
			vial_spritetype += "-s"
		var/mutable_appearance/chem_loaded = mutable_appearance(initial(icon), vial_spritetype)
		chem_loaded.color = vial.chem_color
		. += chem_loaded
	if(vial.greyscale_colors != null)
		var/mutable_appearance/vial_overlay = mutable_appearance(initial(icon), "[vial.icon_state]-body")
		vial_overlay.color = vial.greyscale_colors
		. += vial_overlay
		var/mutable_appearance/vial_overlay_glass = mutable_appearance(initial(icon), "[vial.icon_state]-glass")
		. += vial_overlay_glass
	else
		var/mutable_appearance/vial_overlay = mutable_appearance(initial(icon), vial.icon_state)
		. += vial_overlay

/obj/item/hypospray/mkii/examine(mob/user)
	. = ..()
	if(vial)
		. += "[vial] has [vial.reagents.total_volume]u remaining."
	else
		. += "It has no vial loaded in."
	. += span_notice("Ctrl-Shift-Click to change up the colors or reset them.")

/obj/item/hypospray/mkii/CtrlShiftClick(mob/user, obj/item/I)
	var/choice = tgui_input_list(user, "GAGSify the hypo or reset to default?", "Fashion", list("GAGS", "Nope"))
	if(choice == "GAGS")
		icon_state = gags_bodystate
		//choices go here
		var/atom/fake_atom = src
		var/list/allowed_configs = list()
		var/config = initial(fake_atom.greyscale_config)
		allowed_configs += "[config]"
		if(greyscale_colors == null)
			greyscale_colors = "#00AAFF#FFAA00"

		var/datum/greyscale_modify_menu/menu = new(src, usr, allowed_configs)
		menu.ui_interact(usr)
	else
		icon_state = initial(icon_state)
		icon = initial(icon)
		greyscale_colors = null

/obj/item/hypospray/mkii/proc/unload_hypo(obj/item/hypo, mob/user)
	if((istype(hypo, /obj/item/reagent_containers/cup/hypovial)))
		var/obj/item/reagent_containers/cup/hypovial/container = hypo
		container.forceMove(user.loc)
		user.put_in_hands(container)
		to_chat(user, span_notice("You remove [vial] from [src]."))
		vial = null
		update_icon()
		playsound(loc, 'sound/weapons/empty.ogg', 50, 1)
	else
		to_chat(user, span_notice("This hypo isn't loaded!"))
		return

/obj/item/hypospray/mkii/proc/insert_vial(obj/item/new_vial, mob/living/user)
	if(!is_type_in_list(new_vial, allowed_containers))
		to_chat(user, span_notice("[src] doesn't accept this type of vial."))
		return FALSE
	var/atom/quickswap_loc = new_vial.loc
	if(!user.transferItemToLoc(new_vial, src))
		return FALSE
	if(!isnull(vial))
		if(quickswap_loc == user)
			user.put_in_hands(vial)
		else
			vial.forceMove(quickswap_loc)
	vial = new_vial
	user.visible_message(span_notice("[user] has loaded a vial into [src]."), span_notice("You have loaded [vial] into [src]."))
	playsound(loc, 'sound/weapons/autoguninsert.ogg', 35, 1)
	update_appearance()

/obj/item/hypospray/mkii/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(!istype(tool, /obj/item/reagent_containers/cup/hypovial))
		return NONE
	if(isnull(vial) || quickload)
		insert_vial(tool, user)
		return ITEM_INTERACT_SUCCESS
	to_chat(user, span_warning("[src] can not hold more than one vial!"))
	return ITEM_INTERACT_BLOCKING

/obj/item/hypospray/mkii/attack_self(mob/user)
	. = ..()
	if(vial)
		vial.attack_self(user)
		return TRUE

/obj/item/hypospray/mkii/attack_self_secondary(mob/user)
	. = ..()
	if(vial)
		vial.attack_self_secondary(user)
		return TRUE

/obj/item/hypospray/mkii/emag_act(mob/user)
	. = ..()
	if(obj_flags & EMAGGED)
		to_chat(user, "[src] happens to be already overcharged.")
		return FALSE
	//all these are 0
	inject_wait = COMBAT_WAIT_INJECT
	spray_wait = COMBAT_WAIT_SPRAY
	spray_self = COMBAT_SELF_INJECT
	inject_self = COMBAT_SELF_SPRAY
	penetrates = INJECT_CHECK_PENETRATE_THICK
	to_chat(user, "You overcharge [src]'s control circuit.")
	obj_flags |= EMAGGED
	return TRUE

/obj/item/hypospray/mkii/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(istype(interacting_with, /obj/item/reagent_containers/cup/hypovial))
		insert_vial(interacting_with, user)
		return ITEM_INTERACT_SUCCESS
	return do_inject(interacting_with, user, mode=HYPO_SPRAY)

/obj/item/hypospray/mkii/interact_with_atom_secondary(atom/interacting_with, mob/living/user, list/modifiers)
	return do_inject(interacting_with, user, mode=HYPO_INJECT)

/obj/item/hypospray/mkii/proc/do_inject(mob/living/injectee, mob/living/user, mode)
	if(!isliving(injectee))
		return NONE

	if(!injectee.reagents || !injectee.can_inject(user, user.zone_selected, penetrates))
		return NONE

	if(iscarbon(injectee))
		var/obj/item/bodypart/affecting = injectee.get_bodypart(check_zone(user.zone_selected))
		if(!affecting)
			to_chat(user, span_warning("The limb is missing!"))
			return ITEM_INTERACT_BLOCKING
	//Always log attemped injections for admins
	var/contained = vial.reagents.get_reagent_log_string()
	log_combat(user, injectee, "attemped to inject", src, addition="which had [contained]")

	if(!vial)
		to_chat(user, span_notice("[src] doesn't have any vial installed!"))
		return ITEM_INTERACT_BLOCKING
	if(!vial.reagents.total_volume)
		to_chat(user, span_notice("[src]'s vial is empty!"))
		return ITEM_INTERACT_BLOCKING

	var/fp_verb = mode == HYPO_SPRAY ? "spray" : "inject"

	if(injectee != user)
		injectee.visible_message(span_danger("[user] is trying to [fp_verb] [injectee] with [src]!"), \
						span_userdanger("[user] is trying to [fp_verb] you with [src]!"))

	var/selected_wait_time
	if(injectee == user)
		selected_wait_time = (mode == HYPO_INJECT) ? inject_self : spray_self
	else
		selected_wait_time = (mode == HYPO_INJECT) ? inject_wait : spray_wait

	if(!do_after(user, selected_wait_time, injectee, extra_checks = CALLBACK(injectee, /mob/living/proc/can_inject, user, user.zone_selected, penetrates)))
		return ITEM_INTERACT_BLOCKING
	if(!vial || !vial.reagents.total_volume)
		return ITEM_INTERACT_BLOCKING
	log_attack("<font color='red'>[user.name] ([user.ckey]) applied [src] to [injectee.name] ([injectee.ckey]), which had [contained] (COMBAT MODE: [uppertext(user.combat_mode)]) (MODE: [mode])</font>")
	if(injectee != user)
		injectee.visible_message(span_danger("[user] uses the [src] on [injectee]!"), \
						span_userdanger("[user] uses the [src] on you!"))
	else
		injectee.log_message("<font color='orange'>applied [src] to themselves ([contained]).</font>", LOG_ATTACK)

	switch(mode)
		if(HYPO_INJECT)
			vial.reagents.trans_to(injectee, vial.amount_per_transfer_from_this, methods = INJECT)
		if(HYPO_SPRAY)
			vial.reagents.trans_to(injectee, vial.amount_per_transfer_from_this, methods = PATCH)

	var/long_sound = vial.amount_per_transfer_from_this >= 15
	playsound(loc, long_sound ? 'local/sound/items/hypospray_long.ogg' : pick('local/sound/items/hypospray.ogg','local/sound/items/hypospray2.ogg'), 50, 1, -1)
	to_chat(user, span_notice("You [fp_verb] [vial.amount_per_transfer_from_this] units of the solution. The hypospray's cartridge now contains [vial.reagents.total_volume] units."))
	update_appearance()
	return ITEM_INTERACT_SUCCESS

/obj/item/hypospray/mkii/attack_hand(mob/living/user)
	if(user && loc == user && user.is_holding(src))
		if(user.incapacitated())
			return
		else if(!vial)
			. = ..()
			return
		else
			unload_hypo(vial,user)
	else
		. = ..()

/obj/item/hypospray/mkii/examine(mob/user)
	. = ..()
	. += span_notice("<b>Left-Click</b> on patients to spray, <b>Right-Click</b> to inject.")

// Deluxe hypo upgrade Kit
/obj/item/device/custom_kit/deluxe_hypo2
	name = "hypospray Mk.II deluxe bodykit"
	desc = "Upgrades the DeForest Hypospray Mk. II to support larger vials."
	// don't tinker with a loaded (medi)gun. fool
	from_obj = /obj/item/hypospray/mkii
	to_obj = /obj/item/hypospray/mkii/deluxe

/obj/item/device/custom_kit/deluxe_hypo2/pre_convert_check(obj/target_obj, mob/user)
	var/obj/item/hypospray/mkii/our_hypo = target_obj
	if(our_hypo.type in subtypesof(/obj/item/hypospray/mkii/))
		balloon_alert(user, "only works on basic mk. ii hypos!")
		return FALSE
	if(our_hypo.vial != null)
		balloon_alert(user, "unload the vial first!")
		return FALSE
	return TRUE

#undef HYPO_INJECT
#undef HYPO_SPRAY
#undef WAIT_INJECT
#undef WAIT_SPRAY
#undef SELF_INJECT
#undef SELF_SPRAY
#undef DELUXE_WAIT_INJECT
#undef DELUXE_WAIT_SPRAY
#undef DELUXE_SELF_INJECT
#undef DELUXE_SELF_SPRAY
#undef COMBAT_WAIT_INJECT
#undef COMBAT_WAIT_SPRAY
#undef COMBAT_SELF_INJECT
#undef COMBAT_SELF_SPRAY



/// === HYPOVIAL BREAKER ===
/obj/item/reagent_containers/cup/hypovial
	name = "broken hypovial"
	desc = "You probably shouldn't be seeing this. Shout at a coder."
	icon = 'local/icons/obj/medical/vials.dmi'
	icon_state = "hypovial"
	greyscale_config = /datum/greyscale_config/hypovial
	fill_icon_state = "hypovial_fill"
	spillable = FALSE
	volume = 10
	possible_transfer_amounts = list(1,2,5,10)
	fill_icon_thresholds = list(10, 25, 50, 75, 100)
	var/chem_color = "#FFFFFF" //Used for hypospray overlay
	var/type_suffix = "-s"
	fill_icon = 'local/icons/obj/medical/hypospray_fillings.dmi'
	current_skin = "hypovial"

	unique_reskin = list(
		"Sterile" = "hypovial",
		"Generic" = "hypovial-generic",
		"Brute" = "hypovial-brute",
		"Burn" = "hypovial-burn",
		"Toxin" = "hypovial-tox",
		"Oxyloss" = "hypovial-oxy",
		"Crit" = "hypovial-crit",
		"Buff" = "hypovial-buff",
		"Custom" = "hypovial-custom",
	)

/obj/item/reagent_containers/cup/hypovial/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_OBJ_RESKIN, PROC_REF(on_reskin))

/obj/item/reagent_containers/cup/hypovial/Destroy(force)
	. = ..()
	UnregisterSignal(src, COMSIG_OBJ_RESKIN)

/obj/item/reagent_containers/cup/hypovial/examine(mob/user)
	. = ..()
	. += span_notice("Ctrl-Shift-Click to reskin or set a custom color.")

/obj/item/reagent_containers/cup/hypovial/click_ctrl_shift(mob/user)
	current_skin = null
	icon_state = initial(icon_state)
	icon = initial(icon)
	greyscale_colors = null
	reskin_obj(user)

/obj/item/reagent_containers/cup/hypovial/proc/on_reskin()
	if(current_skin == "Custom")
		icon_state = unique_reskin["Sterile"]
		current_skin = unique_reskin["Sterile"]
		var/atom/fake_atom = src
		var/list/allowed_configs = list()
		var/config = initial(fake_atom.greyscale_config)
		allowed_configs += "[config]"
		if(greyscale_colors == null)
			greyscale_colors = "#FFFF00"
		var/datum/greyscale_modify_menu/menu = new(src, usr, allowed_configs)
		menu.ui_interact(usr)
	else
		icon_state = unique_reskin[current_skin]

/obj/item/reagent_containers/cup/hypovial/update_overlays()
	. = ..()
	// Search the overlays for the fill overlay from reagent_containers, and nudge its layer down to have it look correct.
	chem_color = "#FFFFFF"
	var/list/generated_overlays = .
	for(var/added_overlay in generated_overlays)
		if(istype(added_overlay, /mutable_appearance))
			var/mutable_appearance/overlay_image = added_overlay
			if(findtext(overlay_image.icon_state, fill_icon_state) != 0)
				overlay_image.layer = layer - 0.01
				chem_color = overlay_image.color

/obj/item/reagent_containers/cup/hypovial/Initialize(mapload)
	. = ..()
	update_icon()

/obj/item/reagent_containers/cup/hypovial/on_reagent_change()
	update_icon()

//Fit in all hypos
/obj/item/reagent_containers/cup/hypovial/small
	name = "hypovial"
	desc = "A small, 50u capacity vial compatible with most hyposprays."
	volume = 50
	possible_transfer_amounts = list(1,2,5,10,15,25,50)

/obj/item/reagent_containers/cup/hypovial/small/style
	icon_state = "hypovial"

//Styles
/obj/item/reagent_containers/cup/hypovial/small/style/generic
	icon_state = "hypovial-generic"
/obj/item/reagent_containers/cup/hypovial/small/style/brute
	icon_state = "hypovial-brute"
/obj/item/reagent_containers/cup/hypovial/small/style/burn
	icon_state = "hypovial-burn"
/obj/item/reagent_containers/cup/hypovial/small/style/toxin
	icon_state = "hypovial-tox"
/obj/item/reagent_containers/cup/hypovial/small/style/oxy
	icon_state = "hypovial-oxy"
/obj/item/reagent_containers/cup/hypovial/small/style/crit
	icon_state = "hypovial-crit"
/obj/item/reagent_containers/cup/hypovial/small/style/buff
	icon_state = "hypovial-buff"

//Fit in CMO hypo only
/obj/item/reagent_containers/cup/hypovial/large
	name = "large hypovial"
	icon_state = "hypoviallarge"
	fill_icon_state = "hypoviallarge_fill"
	current_skin = "hypoviallarge"
	desc = "A large, 100u capacity vial that fits only in the most deluxe hyposprays."
	volume = 100
	possible_transfer_amounts = list(1,2,5,10,20,30,40,50,100)
	type_suffix = "-l"

	unique_reskin = list(
		"Sterile" = "hypoviallarge",
		"Generic" = "hypoviallarge-generic",
		"Brute" = "hypoviallarge-brute",
		"Burn" = "hypoviallarge-burn",
		"Toxin" = "hypoviallarge-tox",
		"Oxyloss" = "hypoviallarge-oxy",
		"Crit" = "hypoviallarge-crit",
		"Buff" = "hypoviallarge-buff",
		"Custom" = "hypoviallarge-custom",
	)

/obj/item/reagent_containers/cup/hypovial/large/style/
	icon_state = "hypoviallarge"

//Styles
/obj/item/reagent_containers/cup/hypovial/large/style/generic
	icon_state = "hypoviallarge-generic"
/obj/item/reagent_containers/cup/hypovial/large/style/brute
	icon_state = "hypoviallarge-brute"
/obj/item/reagent_containers/cup/hypovial/large/style/burn
	icon_state = "hypoviallarge-burn"
/obj/item/reagent_containers/cup/hypovial/large/style/toxin
	icon_state = "hypoviallarge-tox"
/obj/item/reagent_containers/cup/hypovial/large/style/oxy
	icon_state = "hypoviallarge-oxy"
/obj/item/reagent_containers/cup/hypovial/large/style/crit
	icon_state = "hypoviallarge-crit"
/obj/item/reagent_containers/cup/hypovial/large/style/buff
	icon_state = "hypoviallarge-buff"

//Hypos that are in the CMO's kit round start
/obj/item/reagent_containers/cup/hypovial/large/deluxe
	name = "deluxe hypovial"
	icon_state = "hypoviallarge-buff"
	list_reagents = list(/datum/reagent/medicine/omnizine = 15, /datum/reagent/medicine/leporazine = 15, /datum/reagent/medicine/atropine = 15)

/obj/item/reagent_containers/cup/hypovial/large/salglu
	name = "large green hypovial (salglu)"
	icon_state = "hypoviallarge-oxy"
	list_reagents = list(/datum/reagent/medicine/salglu_solution = 50)

/obj/item/reagent_containers/cup/hypovial/large/synthflesh
	name = "large orange hypovial (synthflesh)"
	icon_state = "hypoviallarge-crit"
	list_reagents = list(/datum/reagent/medicine/c2/synthflesh = 50)

/obj/item/reagent_containers/cup/hypovial/large/multiver
	name = "large black hypovial (multiver)"
	icon_state = "hypoviallarge-tox"
	list_reagents = list(/datum/reagent/medicine/c2/multiver = 50)

//Some bespoke helper types for preloaded combat medkits.
/obj/item/reagent_containers/cup/hypovial/large/advbrute
	name = "Brute Heal"
	icon_state = "hypoviallarge-brute"
	list_reagents = list(/datum/reagent/medicine/c2/libital = 50, /datum/reagent/medicine/sal_acid = 50)

/obj/item/reagent_containers/cup/hypovial/large/advburn
	name = "Burn Heal"
	icon_state = "hypoviallarge-burn"
	list_reagents = list(/datum/reagent/medicine/c2/aiuri = 50, /datum/reagent/medicine/oxandrolone = 50)

/obj/item/reagent_containers/cup/hypovial/large/advtox
	name = "Toxin Heal"
	icon_state = "hypoviallarge-tox"
	list_reagents = list(/datum/reagent/medicine/pen_acid = 100)

/obj/item/reagent_containers/cup/hypovial/large/advoxy
	name = "Oxy Heal"
	icon_state = "hypoviallarge-oxy"
	list_reagents = list(/datum/reagent/medicine/c2/tirimol = 50, /datum/reagent/medicine/salbutamol = 50)

/obj/item/reagent_containers/cup/hypovial/large/advcrit
	name = "Crit Heal"
	icon_state = "hypoviallarge-crit"
	list_reagents = list(/datum/reagent/medicine/atropine = 100)

/obj/item/reagent_containers/cup/hypovial/large/advomni
	name = "All-Heal"
	icon_state = "hypoviallarge-buff"
	list_reagents = list(/datum/reagent/medicine/regen_jelly = 100)

/obj/item/reagent_containers/cup/hypovial/large/numbing
	name = "Numbing"
	icon_state = "hypoviallarge-generic"
	list_reagents = list(/datum/reagent/medicine/mine_salve = 50, /datum/reagent/medicine/morphine = 50)

//Some bespoke helper types for preloaded paramedic kits.
/obj/item/reagent_containers/cup/hypovial/small/libital
	name = "brute hypovial (libital)"
	icon_state = "hypovial-brute"

/obj/item/reagent_containers/cup/hypovial/small/libital/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/libital, amount = 50, added_purity = 1)

/obj/item/reagent_containers/cup/hypovial/small/lenturi
	name = "burn hypovial (lenturi)"
	icon_state = "hypovial-burn"

/obj/item/reagent_containers/cup/hypovial/small/lenturi/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/lenturi, amount = 50, added_purity = 1)

/obj/item/reagent_containers/cup/hypovial/small/seiver
	name = "tox hypovial (seiver)"
	icon_state = "hypovial-tox"

/obj/item/reagent_containers/cup/hypovial/small/seiver/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/seiver, amount = 50, reagtemp = 975, added_purity = 1)

/obj/item/reagent_containers/cup/hypovial/small/convermol
	name = "tox hypovial (convermol)"
	icon_state = "hypovial-oxy"

/obj/item/reagent_containers/cup/hypovial/small/convermol/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/c2/convermol, amount = 50, added_purity = 1)

/obj/item/reagent_containers/cup/hypovial/small/atropine
	name = "crit hypovial (atropine)"
	icon_state = "hypovial-crit"

/obj/item/reagent_containers/cup/hypovial/small/atropine/Initialize(mapload)
	. = ..()
	reagents.add_reagent(reagent_type = /datum/reagent/medicine/atropine, amount = 50, added_purity = 1)
