/datum/game_mode/slashco
	var/list/slasher_antag_types

/datum/game_mode/slashco/New()
	slasher_antag_types = subtypesof(/datum/antagonist/slasher)

/datum/game_mode/slashco/pre_setup()
	spawn_slashco_generators()
	spawn_slashco_sheets()
	spawn_slashco_items()

	var/list/candidates = list()

	for(var/mob/dead/new_player/player as anything in GLOB.new_player_list)
		if(player.ready == PLAYER_READY_TO_PLAY && player.mind && player.check_preferences())
			candidates.Add(player)

	var/mob/dead/new_player/our_slasher = pick_n_take(candidates)

	// antag stuff takes it from there
	our_slasher.mind.add_antag_datum(pick(slasher_antag_types))
	our_slasher.mind.set_assigned_role(SSjob.GetJobType(/datum/job/slasher))
	our_slasher.mind.special_role = ROLE_SLASHER

	for(var/mob/dead/new_player/employee as anything in candidates)
		employee.mind.set_assigned_role(SSjob.GetJobType(/datum/job/slashco_employee))

	return TRUE

/datum/game_mode/slashco/post_setup(report)
	return ..()

/datum/game_mode/slashco/proc/spawn_slashco_generators()
	for(var/i in 1 to 3)
		var/OurGenerator = pick(GLOB.genstart)
		GLOB.genstart -= OurGenerator
		new /obj/machinery/slashco_generator(OurGenerator)
		var/list/valid_battery_turfs
		for(var/turf/open/turf in range(7, OurGenerator))
			turf += valid_battery_turfs
		new /obj/item/stock_parts/cell/lead(pick(valid_battery_turfs))

/datum/game_mode/slashco/proc/spawn_slashco_sheets()
	for(var/i in 1 to 24) // Double the sheets you'll need
		var/OurSheet = pick(GLOB.fuelstart)
		GLOB.fuelstart -= OurSheet
		new /obj/item/stack/fuel(OurSheet)

/datum/game_mode/slashco/proc/spawn_slashco_items()
	var/static/list/possibleslashcoitems = list(
		/obj/item/toy/faustian_doll,
		/obj/item/food/meat/lab_grown,
		/obj/item/reagent_containers/condiment/mayonnaise/slashco,
		/obj/item/food/cookie,
		/obj/item/reagent_containers/cup/soda_cans/b_gone)

	for(var/i in 1 to rand(6,24))
		var/OurItem = pick(GLOB.slashitemstart)
		GLOB.slashitemstart -= OurItem

		var/our_selection = pick(possibleslashcoitems)
		new our_selection
