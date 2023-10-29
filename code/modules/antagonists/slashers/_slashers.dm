/// Common Slasher Antag Handling Here ///
/datum/antagonist/slasher
	name = "Slasher"
	roundend_category = "slashers"
	job_rank = ROLE_SLASHER
	suicide_cry = "GAME SUCK I GO BED!!"
	antagpanel_category = "Slashers"
	show_to_ghosts = TRUE
	var/mob_type = /mob/living/carbon/human

/datum/antagonist/slasher/get_preview_icon()
	var/icon/icon = icon('local/icons/mob/slashers.dmi', "amogus")
	icon.Scale(ANTAGONIST_PREVIEW_ICON_SIZE, ANTAGONIST_PREVIEW_ICON_SIZE)
	return icon

/datum/antagonist/slasher/roundend_report_header()
	return "<span class='header'>SlashCo's Taken Note Of The Slasher's Activity:</span><br>"

/datum/antagonist/slasher/on_gain()
	. = ..()
	if(!GLOB.generators_spawned)
		spawn_slashco_generators()
		spawn_slashco_sheets()
		spawn_slashco_items()
	equip_slasher()
	forge_objectives()

/proc/spawn_slashco_generators()
	for(var/integer=1 to 3)
		var/OurGenerator = pick(GLOB.genstart)
		GLOB.genstart -= OurGenerator
		new /obj/machinery/slashco_generator(OurGenerator)
		var/list/valid_battery_turfs
		for(var/turf/open/turf in range(7, OurGenerator))
			turf += valid_battery_turfs
		new /obj/item/stock_parts/cell/lead(pick(valid_battery_turfs))

/proc/spawn_slashco_sheets()
	for(var/integer=1 to 24) // Double the sheets you'll need
		var/OurSheet = pick(GLOB.fuelstart)
		GLOB.fuelstart -= OurSheet
		new /obj/item/stack/fuel(OurSheet)

/proc/spawn_slashco_items()
	for(var/integer=1 to rand(6,24))
		var/OurItem = pick(GLOB.slashitemstart)
		GLOB.slashitemstart -= OurItem
		var/list/possibleslashcoitems = list(
			/obj/item/toy/faustian_doll, \
			/obj/item/food/meat/lab_grown, \
			/obj/item/reagent_containers/condiment/mayonnaise/slashco, \
			/obj/item/food/cookie, \
			/obj/item/reagent_containers/cup/soda_cans/b_gone \
		)
		var/our_selection = pick(possibleslashcoitems)
		new our_selection(OurItem)

/datum/antagonist/slasher/proc/equip_slasher(var/OurSlasher = owner.current)
	if(mob_type != /mob/living/carbon/human)
		var/mob/SlasherToBe = OurSlasher
		SlasherToBe.change_mob_type(mob_type, null, null, TRUE)
	give_slasher_abilities(OurSlasher)

/// Exists for subtypes to override.
/datum/antagonist/slasher/proc/give_slasher_abilities()
	return

/datum/antagonist/slasher/forge_objectives()
	. = ..()
	for(var/mob/PotentialTarget in GLOB.player_list)
		if(PotentialTarget.mind.assigned_role == JOB_SLASHCO_EMPLOYEE)
			var/datum/objective/assassinate/new_objective = new /datum/objective/assassinate
			new_objective.owner = owner
			new_objective.target = PotentialTarget
			new_objective.explanation_text = "Kill [PotentialTarget.name]."
			objectives += new_objective

/datum/antagonist/slasher/proc/process_victory()
	for(var/datum/objective/assassinate/objective in objectives)
		if(!(objective.check_completion()))
			return FALSE
	return TRUE
