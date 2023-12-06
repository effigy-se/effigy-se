/mob/living/silicon/robot
	var/hasAffection = FALSE
	var/hasAdvanced = FALSE

/// SHOG NOTE - I don't feel comfortable handing this out to traitors to be honest, it's WAY too powerful. Conversely, it's redundant for nukies.
/// If you can figure out somewhere to best utilize this, please do. I don't feel comfortable outright removing it, either.
/obj/item/borg/upgrade/transform/syndicatejack
	name = "borg module picker (Syndicate)"
	desc = "Allows you to to turn a cyborg into a experimental syndicate cyborg."
	icon_state = "cyborg_upgrade3"
	new_model = /obj/item/robot_model/syndicatejack

/obj/item/borg/upgrade/transform/syndicatejack/action(mob/living/silicon/robot/cyborg, user = usr) // Only usable on emagged cyborgs. In exchange. makes you unable to get locked down or detonated.
	if(cyborg.emagged)
		return ..()

/obj/item/dogborg_tongue
	name = "synthetic tongue"
	desc = "Useful for slurping mess off the floor before affectionally licking the crew members in the face."
	icon = 'local/icons/mob/borgs/robot_items.dmi'
	icon_state = "synthtongue"
	hitsound = 'sound/effects/attackblob.ogg'
	desc = "For giving affectionate kisses."
	item_flags = NOBLUDGEON

/obj/item/dogborg_tongue/afterattack(atom/target, mob/user, proximity)
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

/obj/item/dogborg_nose
	name = "boop module"
	desc = "The BOOP module"
	icon = 'local/icons/mob/borgs/robot_items.dmi'
	icon_state = "nose"
	obj_flags = CONDUCTS_ELECTRICITY
	item_flags = NOBLUDGEON
	force = 0

/obj/item/dogborg_nose/afterattack(atom/target, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	do_attack_animation(target, null, src)
	user.visible_message(span_notice("[user] [pick("nuzzles", "pushes", "boops")] \the [target.name] with their nose!"))

/obj/item/crowbar/cyborg/power
	name = "modular crowbar"
	desc = "A cyborg fitted module resembling the jaws of life."
	icon = 'local/icons/mob/borgs/items_cyborg.dmi'
	icon_state = "jaws_pry_cyborg"
	usesound = 'sound/items/jaws_pry.ogg'
	force = 10
	toolspeed = 0.5

/obj/item/crowbar/cyborg/power/examine()
	. = ..()
	. += " It's fitted with a [tool_behaviour == TOOL_CROWBAR ? "prying" : "cutting"] head."

/obj/item/crowbar/cyborg/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_jaws.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_CROWBAR)
		tool_behaviour = TOOL_WIRECUTTER
		to_chat(user, span_notice("You attach the cutting jaws to [src]."))
		icon_state = "jaws_cutter_cyborg"
		usesound = 'sound/items/jaws_cut.ogg'
	else
		tool_behaviour = TOOL_CROWBAR
		to_chat(user, span_notice("You attach the prying jaws to [src]."))
		icon_state = "jaws_pry_cyborg"
		usesound = 'sound/items/jaws_pry.ogg'

/obj/item/screwdriver/cyborg/power
	name =	"automated drill"
	desc = "A cyborg fitted module resembling the hand drill"
	icon = 'local/icons/mob/borgs/items_cyborg.dmi'
	icon_state = "drill_screw_cyborg"
	hitsound = 'sound/items/drill_hit.ogg'
	usesound = 'sound/items/drill_use.ogg'
	toolspeed = 0.5
	random_color = FALSE

/obj/item/screwdriver/cyborg/power/examine()
	. = ..()
	. += " It's fitted with a [tool_behaviour == TOOL_SCREWDRIVER ? "screw" : "bolt"] head."

/obj/item/screwdriver/cyborg/power/attack_self(mob/user)
	playsound(get_turf(user), 'sound/items/change_drill.ogg', 50, TRUE)
	if(tool_behaviour == TOOL_SCREWDRIVER)
		tool_behaviour = TOOL_WRENCH
		to_chat(user, span_notice("You attach the bolt bit to [src]."))
		icon_state = "drill_bolt_cyborg"
	else
		tool_behaviour = TOOL_SCREWDRIVER
		to_chat(user, span_notice("You attach the screw bit to [src]."))
		icon_state = "drill_screw_cyborg"

/obj/item/borg/upgrade/surgerytools
	name = "medical cyborg advanced surgery tools"
	desc = "An upgrade to the Medical model cyborg's surgery loadout, replacing non-advanced tools with their advanced counterpart."
	icon_state = "cyborg_upgrade3"
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
	icon_state = "cyborg_upgrade3"

/obj/item/borg/upgrade/affectionmodule/action(mob/living/silicon/robot/borg)
	. = ..()
	if(!.)
		return
	if(borg.hasAffection)
		to_chat(usr, span_warning("This unit already has a affection module installed!"))
		return FALSE
	if(!(R_TRAIT_WIDE in borg.model.model_features))
		to_chat(usr, span_warning("This unit's chassis does not support this module."))
		return FALSE

	var/obj/item/dogborg_tongue/dogtongue = new /obj/item/dogborg_tongue(borg.model)
	borg.model.basic_modules += dogtongue
	borg.model.add_module(dogtongue, FALSE, TRUE)
	var/obj/item/dogborg_nose/dognose = new /obj/item/dogborg_nose(borg.model)
	borg.model.basic_modules += dognose
	borg.model.add_module(dognose, FALSE, TRUE)
	borg.hasAffection = TRUE

/obj/item/borg/upgrade/affectionmodule/deactivate(mob/living/silicon/robot/borg, user = usr)
	. = ..()
	if(.)
		return
	borg.hasAffection = FALSE
	for(var/obj/item/dogborg_tongue/dogtongue in borg.model.modules)
		borg.model.remove_module(dogtongue, TRUE)
	for(var/obj/item/dogborg_nose/dognose in borg.model.modules)
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
	icon_state = "cyborg_upgrade3"
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
	name = "Cyborg Inducer"
	desc = "A tool for inductively charging internal power cells using the battery of a cyborg"
	powertransfer = 250
	var/power_safety_threshold = 1000



/obj/item/inducer/cyborg/attackby(obj/item/weapon, mob/user)
	return

/obj/item/inducer/cyborg/recharge(atom/movable/target_atom, mob/user)
	if(!iscyborg(user))
		return
	var/mob/living/silicon/robot/borg_user = user
	cell = borg_user.cell
	if(!isturf(target_atom) && user.loc == target_atom)
		return FALSE
	if(recharging)
		return TRUE
	else
		recharging = TRUE
	var/obj/item/stock_parts/cell/target_cell = target_atom.get_cell()
	var/obj/target_object
	var/coefficient = 1
	if(istype(target_atom, /obj/item/gun/energy))
		to_chat(user, span_alert("Error unable to interface with device."))
		return FALSE
	if(istype(target_atom, /obj/item/clothing/suit/space))
		to_chat(user, span_alert("Error unable to interface with device."))
		return FALSE
	if(cell.charge <= power_safety_threshold ) // Cyborg charge safety. Prevents a borg from inducing themself to death.
		to_chat(user, span_alert("Unable to charge device. User battery safety engaged."))
		return
	if(istype(target_atom, /obj))
		target_object = target_atom
	if(target_cell)
		var/done_any = FALSE
		if(target_cell.charge >= target_cell.maxcharge)
			to_chat(user, span_notice("[target_atom] is fully charged!"))
			recharging = FALSE
			return TRUE
		user.visible_message(span_notice("[user] starts recharging [target_atom] with [src]."), span_notice("You start recharging [target_atom] with [src]."))
		while(target_cell.charge < target_cell.maxcharge)
			if(do_after(user, 1 SECONDS, target = user) && cell.charge > (power_safety_threshold + powertransfer))
				done_any = TRUE
				induce(target_cell, coefficient)
				do_sparks(1, FALSE, target_atom)
				if(target_object)
					target_object.update_appearance()
			else
				break
		if(done_any) // Only show a message if we succeeded at least once
			user.visible_message(span_notice("[user] recharged [target_atom]!"), span_notice("You recharged [target_atom]!"))
		recharging = FALSE
		return TRUE
	recharging = FALSE


/obj/item/inducer/attack(mob/target_mob, mob/living/user)
	if(user.combat_mode)
		return ..()

	if(cantbeused(user))
		return

	if(recharge(target_mob, user))
		return
	return ..()

/obj/item/inducer/cyborg/attack_self(mob/user)
	return

// funny borg inducer upgrade
/obj/item/borg/upgrade/inducer
	name = "engineering cyborg inducer upgrade"
	desc = "An inducer device for the engineering cyborg."
	icon_state = "cyborg_upgrade3"
	require_model = TRUE
	model_type = list(/obj/item/robot_model/engineering, /obj/item/robot_model/saboteur)
	model_flags = BORG_MODEL_ENGINEERING

/obj/item/borg/upgrade/inducer/action(mob/living/silicon/robot/target_robot, user = usr)
	. = ..()
	if(.)

		var/obj/item/inducer/cyborg/inducer = locate() in target_robot
		if(inducer)
			to_chat(user, span_warning("This unit is already equipped with an inducer module!"))
			return FALSE

		inducer = new(target_robot.model)
		target_robot.model.basic_modules += inducer
		target_robot.model.add_module(inducer, FALSE, TRUE)

/obj/item/borg/upgrade/inducer/deactivate(mob/living/silicon/robot/target_robot, user = usr)
	. = ..()
	if (.)
		var/obj/item/inducer/cyborg/inducer = locate() in target_robot.model
		if (inducer)
			target_robot.model.remove_module(inducer, TRUE)

// Wirebrush for janiborg
/datum/design/borg_wirebrush
	name = "Wire-brush Module"
	id = "borg_upgrade_brush"
	build_type = MECHFAB
	build_path = /obj/item/borg/upgrade/wirebrush
	materials = list(/datum/material/iron = 4000)
	construction_time = 40
	category = list(RND_CATEGORY_MECHFAB_CYBORG_MODULES + RND_SUBCATEGORY_MECHFAB_CYBORG_MODULES_JANITOR)

/obj/item/borg/upgrade/wirebrush
	name = "janitor cyborg wire-brush"
	desc = "A tool to remove rust from walls."
	icon_state = "cyborg_upgrade3"
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

/obj/item/borg_snack_dispenser/AltClick(mob/user)
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
