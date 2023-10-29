/datum/game_mode/slashco

/datum/game_mode/slashco/New()
	. = ..()

/datum/game_mode/slashco/pre_setup()
	spawn_slashco_generators()
	spawn_slashco_sheets()
	spawn_slashco_items()
	spawn_slashco_batteries()
	return TRUE

/datum/game_mode/slashco/post_setup(report)
	return ..()

/datum/game_mode/slashco/proc/spawn_slashco_generators()
	for(var/i in 1 to 3)
		var/OurGenerator = pick(GLOB.genstart)
		GLOB.genstart -= OurGenerator
		new /obj/machinery/slashco_generator(OurGenerator)

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

/datum/game_mode/slashco/proc/spawn_slashco_batteries()
	for(var/i in 1 to 3)
		var/OurBattery = pick(GLOB.batterystart)
		GLOB.batterystart -= OurBattery
		new /obj/item/stock_parts/cell/lead(OurBattery)
