/mob/living/silicon/robot
	var/hasShrunk = FALSE
	var/hasAffection = FALSE
	var/hasAdvanced = FALSE

/// SHOG NOTE - I don't feel comfortable handing this out to traitors to be honest, it's WAY too powerful. Conversely, it's redundant for nukies.
/// If you can figure out somewhere to best utilize this, please do. I don't feel comfortable outright removing it, either.
/obj/item/borg/upgrade/transform/syndicatejack
	name = "borg module picker (Syndicate)"
	desc = "Allows you to to turn a cyborg into a experimental syndicate cyborg."
	icon_state = "module_general"
	new_model = /obj/item/robot_model/syndicatejack

/obj/item/borg/upgrade/transform/syndicatejack/action(mob/living/silicon/robot/cyborg, user = usr) // Only usable on emagged cyborgs. In exchange. makes you unable to get locked down or detonated.
	if(cyborg.emagged)
		return ..()

/obj/item/quadborg_tongue
	name = "synthetic tongue"
	desc = "Useful for slurping mess off the floor before affectionally licking the crew members in the face."
	icon = 'local/icons/mob/borgs/robot_items.dmi'
	icon_state = "synthtongue"
	hitsound = 'sound/effects/attackblob.ogg'
	desc = "For giving affectionate kisses."
	item_flags = NOBLUDGEON

/obj/item/quadborg_tongue/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity || !isliving(target))
		return
	var/mob/living/silicon/robot/borg = user
	var/mob/living/mob = target

	if(check_zone(borg.zone_selected) == "head")
		borg.visible_message(span_warning("\the [borg] affectionally licks \the [mob]'s face!"), span_notice("You affectionally lick \the [mob]'s face!"))
		playsound(borg, 'sound/effects/attackblob.ogg', 50, 1)
	else
		borg.visible_message(span_warning("\the [borg] affectionally licks \the [mob]!"), span_notice("You affectionally lick \the [mob]!"))
		playsound(borg, 'sound/effects/attackblob.ogg', 50, 1)

/obj/item/quadborg_nose
	name = "boop module"
	desc = "The BOOP module"
	icon = 'local/icons/mob/borgs/robot_items.dmi'
	icon_state = "nose"
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	force = 0

/obj/item/quadborg_nose/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	do_attack_animation(target, null, src)
	user.visible_message(span_notice("[user] [pick("nuzzles", "pushes", "boops")] \the [target.name] with their nose!"))

/obj/item/borg/upgrade/surgerytools
	name = "medical cyborg advanced surgery tools"
	desc = "An upgrade to the Medical model cyborg's surgery loadout, replacing non-advanced tools with their advanced counterpart."
	icon_state = "module_general"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/medical)
	model_flags = BORG_MODEL_MEDICAL

/obj/item/borg/upgrade/surgerytools/action(mob/living/silicon/robot/borg)
	. = ..()
	if(.)
		for(var/obj/item/retractor/RT in borg.model.modules)
			borg.model.remove_module(RT, TRUE)
		for(var/obj/item/hemostat/HS in borg.model.modules)
			borg.model.remove_module(HS, TRUE)
		for(var/obj/item/cautery/CT in borg.model.modules)
			borg.model.remove_module(CT, TRUE)
		for(var/obj/item/surgicaldrill/SD in borg.model.modules)
			borg.model.remove_module(SD, TRUE)
		for(var/obj/item/scalpel/SP in borg.model.modules)
			borg.model.remove_module(SP, TRUE)
		for(var/obj/item/circular_saw/CS in borg.model.modules)
			borg.model.remove_module(CS, TRUE)
		for(var/obj/item/healthanalyzer/HA in borg.model.modules)
			borg.model.remove_module(HA, TRUE)

		var/obj/item/scalpel/advanced/AS = new /obj/item/scalpel/advanced(borg.model)
		borg.model.basic_modules += AS
		borg.model.add_module(AS, FALSE, TRUE)
		var/obj/item/retractor/advanced/AR = new /obj/item/retractor/advanced(borg.model)
		borg.model.basic_modules += AR
		borg.model.add_module(AR, FALSE, TRUE)
		var/obj/item/cautery/advanced/AC = new /obj/item/cautery/advanced(borg.model)
		borg.model.basic_modules += AC
		borg.model.add_module(AC, FALSE, TRUE)
		var/obj/item/healthanalyzer/advanced/AHA = new /obj/item/healthanalyzer/advanced(borg.model)
		borg.model.basic_modules += AHA
		borg.model.add_module(AHA, FALSE, TRUE)

/obj/item/borg/upgrade/surgerytools/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(.)
		for(var/obj/item/scalpel/advanced/AS in borg.model.modules)
			borg.model.remove_module(AS, TRUE)
		for(var/obj/item/retractor/advanced/AR in borg.model.modules)
			borg.model.remove_module(AR, TRUE)
		for(var/obj/item/cautery/advanced/AC in borg.model.modules)
			borg.model.remove_module(AC, TRUE)
		for(var/obj/item/healthanalyzer/advanced/AHA in borg.model.modules)
			borg.model.remove_module(AHA, TRUE)

		var/obj/item/retractor/RT = new (borg.model)
		borg.model.basic_modules += RT
		borg.model.add_module(RT, FALSE, TRUE)
		var/obj/item/hemostat/HS = new (borg.model)
		borg.model.basic_modules += HS
		borg.model.add_module(HS, FALSE, TRUE)
		var/obj/item/cautery/CT = new (borg.model)
		borg.model.basic_modules += CT
		borg.model.add_module(CT, FALSE, TRUE)
		var/obj/item/surgicaldrill/SD = new (borg.model)
		borg.model.basic_modules += SD
		borg.model.add_module(SD, FALSE, TRUE)
		var/obj/item/scalpel/SP = new (borg.model)
		borg.model.basic_modules += SP
		borg.model.add_module(SP, FALSE, TRUE)
		var/obj/item/circular_saw/CS = new (borg.model)
		borg.model.basic_modules += CS
		borg.model.add_module(CS, FALSE, TRUE)
		var/obj/item/healthanalyzer/HA = new (borg.model)
		borg.model.basic_modules += HA
		borg.model.add_module(HA, FALSE, TRUE)

/obj/item/borg/upgrade/affectionmodule
	name = "borg affection module"
	desc = "A module that upgrades the ability of borgs to display affection."
	icon_state = "module_general"

/obj/item/borg/upgrade/affectionmodule/action(mob/living/silicon/robot/borg)
	. = ..()
	if(!.)
		return
	if(borg.hasAffection)
		to_chat(usr, span_warning("This unit already has a affection module installed!"))
		return FALSE
	if(!(TRAIT_R_WIDE in borg.model.model_features))
		to_chat(usr, span_warning("This unit's chassis does not support this module."))
		return FALSE

	var/obj/item/quadborg_tongue/dogtongue = new /obj/item/quadborg_tongue(borg.model)
	borg.model.basic_modules += dogtongue
	borg.model.add_module(dogtongue, FALSE, TRUE)
	var/obj/item/quadborg_nose/dognose = new /obj/item/quadborg_nose(borg.model)
	borg.model.basic_modules += dognose
	borg.model.add_module(dognose, FALSE, TRUE)
	borg.hasAffection = TRUE

/obj/item/borg/upgrade/affectionmodule/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(.)
		return
	borg.hasAffection = FALSE
	for(var/obj/item/quadborg_tongue/dogtongue in borg.model.modules)
		borg.model.remove_module(dogtongue, TRUE)
	for(var/obj/item/quadborg_nose/dognose in borg.model.modules)
		borg.model.remove_module(dognose, TRUE)

/*
*	ADVANCED ENGINEERING CYBORG MATERIALS
*/

#define ENGINEERING_CYBORG_CHARGE_PER_STACK 1000

/datum/robot_energy_storage/plasteel
	name = "Plasteel Processor"
	recharge_rate = 0
	max_energy = ENGINEERING_CYBORG_CHARGE_PER_STACK * 50

/datum/robot_energy_storage/titanium
	name = "Titanium Processor"
	recharge_rate = 0
	max_energy = ENGINEERING_CYBORG_CHARGE_PER_STACK * 50

/obj/item/stack/sheet/plasteel/cyborg
	cost = ENGINEERING_CYBORG_CHARGE_PER_STACK
	is_cyborg = TRUE
	source = /datum/robot_energy_storage/plasteel

/obj/item/stack/sheet/titaniumglass/cyborg
	cost = ENGINEERING_CYBORG_CHARGE_PER_STACK
	is_cyborg = TRUE
	source = /datum/robot_energy_storage/titanium

/obj/item/borg/upgrade/advanced_materials
	name = "engineering advanced materials processor"
	desc = "allows a cyborg to synthesize and store advanced materials"
	icon_state = "module_general"
	model_type = list(/obj/item/robot_model/engineering)
	model_flags = BORG_MODEL_ENGINEERING

/obj/item/borg/upgrade/advanced_materials/action(mob/living/silicon/robot/borgo, user)
	. = ..()
	if(!.)
		return
	if(borgo.hasAdvanced)
		to_chat(user, span_warning("This unit already has advanced materials installed!"))
		return FALSE;

	var/obj/item/stack/sheet/plasteel/cyborg/plasteel_holder = new(borgo.model)
	var/obj/item/stack/sheet/titaniumglass/cyborg/titanium_holder = new(borgo.model)
	borgo.model.basic_modules += plasteel_holder
	borgo.model.basic_modules += titanium_holder
	borgo.model.add_module(plasteel_holder, FALSE, TRUE)
	borgo.model.add_module(titanium_holder, FALSE, TRUE)
	borgo.hasAdvanced = TRUE

/obj/item/borg/upgrade/advanced_materials/deactivate(mob/living/silicon/robot/borgo, user)
	. = ..()
	if(!.)
		return
	borgo.hasAdvanced = FALSE
	for(var/obj/item/stack/sheet/plasteel/cyborg/plasteel_holder in borgo.model.modules)
		borgo.model.remove_module(plasteel_holder, TRUE)
	for(var/obj/item/stack/sheet/titaniumglass/cyborg/titanium_holder in borgo.model.modules)
		borgo.model.remove_module(titanium_holder, TRUE)
	for(var/datum/robot_energy_storage/plasteel/plasteel_energy in borgo.model.storages)
		qdel(plasteel_energy)
	for(var/datum/robot_energy_storage/titanium/titanium_energy in borgo.model.storages)
		qdel(titanium_energy)

/obj/item/inducer/cyborg
	name = "Internal inducer"
	icon = 'icons/obj/tools.dmi'
	icon_state = "inducer-engi"
	cell_type = null

/obj/item/inducer/cyborg/get_cell()
	var/obj/item/robot_model/possible_model = loc
	var/mob/living/silicon/robot/silicon_friend = istype(possible_model) ? possible_model.robot : possible_model
	if(istype(silicon_friend))
		. = silicon_friend.cell

/*
*	ADVANCED CARGO CYBORG UPGRADES
*/

/// Better Clamp
/obj/item/borg/hydraulic_clamp/better
	name = "improved integrated hydraulic clamp"
	desc = "A neat way to lift and move around crates for quick and painless deliveries!"
	storage_capacity = 4
	whitelisted_item_types = list(/obj/structure/closet/crate, /obj/item/delivery/big, /obj/item/delivery, /obj/item/bounty_cube) // If they want to carry a small package or a bounty cube instead, so be it, honestly.
	whitelisted_item_description = "wrapped packages"
	item_weight_limit = NONE
	clamp_sound_volume = 50

/obj/item/borg/hydraulic_clamp/better/examine(mob/user)
	. = ..()
	var/crate_count = contents.len
	. += "There is currently <b>[crate_count > 0 ? crate_count : "no"]</b> crate[crate_count > 1 ? "s" : ""] stored in the clamp's internal storage."

/obj/item/borg/hydraulic_clamp/mail
	name = "integrated rapid mail delivery device"
	desc = "Allows you to carry around a lot of mail, to distribute it around the station like the good little mailbot you are!"
	icon = 'icons/obj/service/library.dmi'
	icon_state = "bookbag"
	storage_capacity = 100
	loading_time = 0.25 SECONDS
	unloading_time = 0.25 SECONDS
	cooldown_duration = 0.25 SECONDS
	whitelisted_item_types = list(/obj/item/mail)
	whitelisted_item_description = "envelopes"
	item_weight_limit = WEIGHT_CLASS_NORMAL
	clamp_sound_volume = 25
	clamp_sound = 'sound/items/pshoom.ogg'

/datum/design/borg_upgrade_clamp
	name = "improved Integrated Hydraulic Clamp Module"
	id = "borg_upgrade_clamp"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/better_clamp
	materials = list(
		/datum/material/titanium = SHEET_MATERIAL_AMOUNT * 2,
		/datum/material/gold = HALF_SHEET_MATERIAL_AMOUNT,
		/datum/material/bluespace = HALF_SHEET_MATERIAL_AMOUNT,
	)
	construction_time = 12 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_CARGO,
	)


/obj/item/borg/upgrade/better_clamp
	name = "improved integrated hydraulic clamp"
	desc = "An improved hydraulic clamp to allow for bigger packages to be picked up as well!"
	icon_state = "module_general"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/cargo)
	model_flags = BORG_MODEL_CARGO


/obj/item/borg/upgrade/better_clamp/action(mob/living/silicon/robot/cyborg, user = usr)
	. = ..()
	if(!.)
		return
	var/obj/item/borg/hydraulic_clamp/better/big_clamp = locate() in cyborg.model.modules
	if(big_clamp)
		to_chat(user, span_warning("This cyborg is already equipped with an improved integrated hydraulic clamp!"))
		return FALSE

	big_clamp = new(cyborg.model)
	cyborg.model.basic_modules += big_clamp
	cyborg.model.add_module(big_clamp, FALSE, TRUE)


/obj/item/borg/upgrade/better_clamp/deactivate(mob/living/silicon/robot/cyborg, user = usr)
	. = ..()
	if(!.)
		return
	var/obj/item/borg/hydraulic_clamp/better/big_clamp = locate() in cyborg.model.modules
	if(big_clamp)
		cyborg.model.remove_module(big_clamp, TRUE)

// Wirebrush for janiborg
/datum/design/borg_wirebrush
	name = "Wire-brush Module"
	id = "borg_upgrade_brush"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/wirebrush
	materials = list(
		/datum/material/iron = SHEET_MATERIAL_AMOUNT * 2
	)
	construction_time = 4 SECONDS
	category = list(
		RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR,
	)

/obj/item/borg/upgrade/wirebrush
	name = "janitor cyborg wire-brush"
	desc = "A tool to remove rust from walls."
	icon_state = "module_general"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/janitor)
	model_flags = BORG_MODEL_JANITOR

/obj/item/borg/upgrade/wirebrush/action(mob/living/silicon/robot/cyborg)
	. = ..()
	if(.)
		for(var/obj/item/wirebrush/brush in cyborg.model.modules)
			cyborg.model.remove_module(brush, TRUE)

		var/obj/item/wirebrush/brush = new /obj/item/wirebrush(cyborg.model)
		cyborg.model.basic_modules += brush
		cyborg.model.add_module(brush, FALSE, TRUE)

/obj/item/borg/upgrade/wirebrush/deactivate(mob/living/silicon/robot/cyborg, user = usr)
	. = ..()
	if(.)
		for(var/obj/item/wirebrush/brush in cyborg.model.modules)
			cyborg.model.remove_module(brush, TRUE)

		var/obj/item/wirebrush/brush = new (cyborg.model)
		cyborg.model.basic_modules += brush
		cyborg.model.add_module(brush, FALSE, TRUE)

/obj/item/borg/upgrade/snack_dispenser
	name = "Snack Dispenser Module"
	desc = "Gives any borg the ability to dispense speciality snacks."
	/// For storing modules that we remove, since the upgraded snack dispenser automatically removes inferior versions
	var/list/removed_modules = list()

/obj/item/borg/upgrade/snack_dispenser/action(mob/living/silicon/robot/R, user)
	. = ..()
	if(!.)
		return
	var/obj/item/borg_snack_dispenser/snack_dispenser = new(R.model)
	R.model.basic_modules += snack_dispenser
	R.model.add_module(snack_dispenser, FALSE, TRUE)
	for(var/obj/item/rsf/cookiesynth/cookiesynth in R.model)
		removed_modules += cookiesynth
		R.model.remove_module(cookiesynth)
	for(var/obj/item/borg/lollipop/lollipop in R.model)
		removed_modules += lollipop
		R.model.remove_module(lollipop)

/obj/item/borg/upgrade/snack_dispenser/deactivate(mob/living/silicon/robot/R, user)
	. = ..()
	if(!.)
		return
	for(var/obj/item/borg_snack_dispenser/dispenser in R.model)
		R.model.remove_module(dispenser, TRUE)
	for(var/obj/item as anything in removed_modules)
		R.model.basic_modules += item
		R.model.add_module(item, FALSE, TRUE)

/obj/item/borg_snack_dispenser
	name = "\improper Automated Borg Snack Dispenser"
	desc = "Has the ability to automatically print many differnt forms of snacks. Now Lizard approved!"
	icon = 'icons/obj/tools.dmi'
	icon_state = "rsf"
	/// Contains the PATH of the selected snack
	var/atom/selected_snack
	/// Whether snacks are launched when targeted at a distance
	var/launch_mode = FALSE
	/// A list of all valid snacks
	var/list/valid_snacks = list(
		/obj/item/food/cookie/bacon,
		/obj/item/food/cookie/cloth,
		/obj/item/food/cookie/sugar,
		/obj/item/food/lollipop/cyborg
	)
	/// Minimum amount of charge a borg can have before snack printing is disallowed
	var/borg_charge_cutoff = 200
	/// The amount of charge used per print of a snack
	var/borg_charge_usage = 50

/obj/item/borg_snack_dispenser/Initialize(mapload)
	. = ..()
	selected_snack = selected_snack ||  LAZYACCESS(valid_snacks, 1)

/obj/item/borg_snack_dispenser/examine(mob/user)
	. = ..()
	. += "It is currently set to dispense [initial(selected_snack.name)]."
	. += "You can AltClick it to [(launch_mode ? "disable" : "enable")] launch mode."

/obj/item/borg_snack_dispenser/attack_self(mob/user, modifiers)
	var/list/choices = list()
	for(var/atom/snack as anything in valid_snacks)
		choices[initial(snack.name)] = snack
	if(!length(choices))
		to_chat(user, span_warning("No valid snacks in database."))
	if(length(choices) == 1)
		selected_snack = choices[1]
	else
		var/selected = tgui_input_list(user, "Select Snack", "Snack Selection", choices)
		if(!selected)
			return
		selected_snack = choices[selected]
	var/snack_name = initial(selected_snack.name)
	to_chat(user, span_notice("[src] is now dispensing [snack_name]."))

/obj/item/borg_snack_dispenser/attack(mob/living/patron, mob/living/silicon/robot/user, params)
	var/empty_hand = LAZYACCESS(patron.get_empty_held_indexes(), 1)
	if(!empty_hand)
		to_chat(user, span_warning("[patron] has no free hands!"))
		return
	if(!selected_snack)
		to_chat(user, span_warning("No snack selected."))
		return
	if(!istype(user))
		CRASH("[src] being used by non borg [user]")
	if(user.cell.charge < borg_charge_cutoff)
		to_chat(user, span_danger("Automated Safety Measures restrict the operation of [src] while under [borg_charge_cutoff]!"))
		return
	if(!user.cell.use(borg_charge_usage))
		to_chat(user, span_danger("Failure printing snack: power failure!"))
		return
	var/atom/snack = new selected_snack(src)
	patron.put_in_hand(snack, empty_hand)
	user.do_item_attack_animation(patron, null, snack)
	playsound(loc, 'sound/machines/click.ogg', 10, TRUE)
	to_chat(patron, span_notice("[user] dispenses [snack] into your empty hand and you reflexively grasp it."))
	to_chat(user, span_notice("You dispense [snack] into the hand of [user]."))

/obj/item/borg_snack_dispenser/click_alt(mob/user)
	launch_mode = !launch_mode
	to_chat(user, span_notice("[src] is [(launch_mode ? "now" : "no longer")] launching snacks at a distance."))

/obj/item/borg_snack_dispenser/afterattack(atom/target, mob/living/silicon/robot/user, proximity_flag, click_parameters)
	if(Adjacent(target) || !launch_mode)
		return ..()
	if(!selected_snack)
		to_chat(user, span_warning("No snack selected."))
		return
	if(!istype(user))
		CRASH("[src] being used by non borg [user]")
	if(user.cell.charge < borg_charge_cutoff)
		to_chat(user, span_danger("Automated Safety Measures restrict the operation of [src] while under [borg_charge_cutoff]!"))
		return
	if(!user.cell.use(borg_charge_usage))
		to_chat(user, span_danger("Failure printing snack: power failure!"))
		return
	var/atom/movable/snack = new selected_snack(get_turf(src))
	snack.throw_at(target, 7, 2, user, TRUE, FALSE)
	playsound(loc, 'sound/machines/click.ogg', 10, TRUE)
	user.visible_message(span_notice("[src] launches [snack] at [target]!"))

/*
*	UNIVERSAL CYBORG UPGRADES
*/

/// ShapeShifter
/obj/item/borg/upgrade/borg_shapeshifter
	name = "Cyborg Shapeshifter Module"
	desc = "An experimental device which allows a cyborg to disguise themself into another type of cyborg."
	icon_state = "module_general"

/obj/item/borg/upgrade/borg_shapeshifter/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		var/obj/item/borg_shapeshifter/BS = new /obj/item/borg_shapeshifter(R.model)
		R.model.basic_modules += BS
		R.model.add_module(BS, FALSE, TRUE)

/obj/item/borg/upgrade/borg_shapeshifter/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		for(var/obj/item/borg_shapeshifter/BS in R.model)
			R.model.remove_module(BS, TRUE)

/// The Shrinkening

/obj/item/borg/upgrade/shrink
	name = "borg shrinker"
	desc = "A cyborg resizer, it makes a cyborg small."
	icon_state = "module_general"

/obj/item/borg/upgrade/shrink/action(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(.)

		if(borg.hasShrunk)
			to_chat(usr, span_warning("This unit already has a shrink module installed!"))
			return FALSE
		if(TRAIT_R_SMALL in borg.model.model_features)
			to_chat(usr, span_warning("This unit's chassis cannot be shrunk any further."))
			return FALSE
		borg.hasShrunk = TRUE
		ADD_TRAIT(borg, TRAIT_NO_TRANSFORM, REF(src))
		var/prev_lockcharge = borg.lockcharge
		borg.SetLockdown(TRUE)
		borg.set_anchored(TRUE)
		var/datum/effect_system/fluid_spread/smoke/smoke = new
		smoke.set_up(1, location = get_turf(borg))
		smoke.start()
		sleep(0.2 SECONDS)
		for(var/i in 1 to 4)
			playsound(borg, pick('sound/items/drill_use.ogg', 'sound/items/jaws_cut.ogg', 'sound/items/jaws_pry.ogg', 'sound/items/welder.ogg', 'sound/items/ratchet.ogg'), 80, TRUE, -1)
			sleep(1.2 SECONDS)
		if(!prev_lockcharge)
			borg.SetLockdown(FALSE)
		borg.set_anchored(FALSE)
		REMOVE_TRAIT(borg, TRAIT_NO_TRANSFORM, REF(src))
		borg.update_transform(0.90)

/obj/item/borg/upgrade/shrink/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if (.)
		if (borg.hasShrunk)
			borg.hasShrunk = FALSE
			borg.update_transform(4/3)

/// Dominatrix time
/obj/item/borg/upgrade/dominatrixmodule
	name = "borg dominatrix module"
	desc = "A module that greatly upgrades the ability of borgs to display affection."
	icon_state = "module_general"
	custom_price = 0

/obj/item/borg/upgrade/dominatrixmodule/action(mob/living/silicon/robot/borg)
	. = ..()
	if(!.)
		return
	var/obj/item/kinky_shocker/cur_shocker = locate() in borg.model.modules
	if(cur_shocker)
		to_chat(usr, span_warning("This unit already has a dominatrix module installed!"))
		return FALSE

	var/obj/item/kinky_shocker/shocker = new /obj/item/kinky_shocker()
	borg.model.basic_modules += shocker
	borg.model.add_module(shocker, FALSE, TRUE)
	var/obj/item/clothing/mask/leatherwhip/whipper = new /obj/item/clothing/mask/leatherwhip()
	borg.model.basic_modules += whipper
	borg.model.add_module(whipper, FALSE, TRUE)
	var/obj/item/spanking_pad/spanker = new /obj/item/spanking_pad()
	borg.model.basic_modules += spanker
	borg.model.add_module(spanker, FALSE, TRUE)
	var/obj/item/tickle_feather/tickler = new /obj/item/tickle_feather()
	borg.model.basic_modules += tickler
	borg.model.add_module(tickler, FALSE, TRUE)

/obj/item/borg/upgrade/dominatrixmodule/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(!.)
		return

	for(var/obj/item/kinky_shocker/shocker in borg.model.modules)
		borg.model.remove_module(shocker, TRUE)
	for(var/obj/item/clothing/mask/leatherwhip/whipper in borg.model.modules)
		borg.model.remove_module(whipper, TRUE)
	for(var/obj/item/spanking_pad/spanker in borg.model.modules)
		borg.model.remove_module(spanker, TRUE)
	for(var/obj/item/tickle_feather/tickler in borg.model.modules)
		borg.model.remove_module(tickler, TRUE)

/*
*	ADVANCED MINING CYBORG UPGRADES
*/

/// Welder
/obj/item/borg/upgrade/welder
	name = "mining cyborg welder upgrade"
	desc = "A normal welder with a larger tank for cyborgs."
	icon_state = "module_general"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/miner)
	model_flags = BORG_MODEL_MINER

/obj/item/borg/upgrade/welder/action(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if(.)
		for(var/obj/item/weldingtool/mini/W in R.model)
			R.model.remove_module(W, TRUE)

		var/obj/item/weldingtool/largetank/cyborg/WW = new /obj/item/weldingtool/largetank/cyborg(R.model)
		R.model.basic_modules += WW
		R.model.add_module(WW, FALSE, TRUE)

/obj/item/borg/upgrade/welder/deactivate(mob/living/silicon/robot/R, user = usr)
	. = ..()
	if (.)
		for(var/obj/item/weldingtool/largetank/cyborg/WW in R.model)
			R.model.remove_module(WW, TRUE)

		var/obj/item/weldingtool/mini/W = new (R.model)
		R.model.basic_modules += W
		R.model.add_module(W, FALSE, TRUE)
