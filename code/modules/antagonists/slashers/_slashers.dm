/// Common Slasher Antag Handling Here ///
/datum/antagonist/slasher
	name = "Slasher"
	roundend_category = "slashers"
	job_rank = ROLE_SLASHER
	suicide_cry = "GAME SUCK I GO BED!!"
	antagpanel_category = "Slashers"
	show_to_ghosts = TRUE

/// TODO: Preview Icon Here

/datum/antagonist/slasher/on_gain()
	. = ..()
	if(!GLOB.generators_spawned)
		spawn_slashco_generators()
		spawn_slashco_sheets()
		spawn_slashco_batteries()

/proc/spawn_slashco_generators()
	for(var/integer=1 to 3)
		var/OurGenerator = pick(GLOB.genstart)
		GLOB.genstart -= OurGenerator
		new /obj/machinery/slashco_generator(OurGenerator)

/proc/spawn_slashco_sheets()
	for(var/integer=1 to 24) // Double the sheets you'll need
		var/OurSheet = pick(GLOB.fuelstart)
		GLOB.fuelstart -= OurSheet
		new /obj/item/stack/fuel(OurSheet)

/proc/spawn_slashco_batteries()
	for(var/integer=1 to 3)
		var/OurBattery = pick(GLOB.batterystart)
		GLOB.batterystart -= OurBattery
		new /obj/item/stock_parts/cell/lead(OurBattery)

/datum/antagonist/slasher/test_slasher
	name = "Testy The Test Slasher"
