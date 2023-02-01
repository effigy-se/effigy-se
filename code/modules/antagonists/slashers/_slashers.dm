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

/// This is unironically the worst piece of coding I've done for this project so far
/// And I look forward to some poor soul stumbling on this in a few months and weeping
/proc/spawn_slashco_generators()
	var/GeneratorOne = pick(GLOB.genstart)
	GLOB.genstart -= GeneratorOne
	new /obj/machinery/slashco_generator(GeneratorOne)
	var/GeneratorTwo = pick(GLOB.genstart)
	GLOB.genstart -= GeneratorTwo
	new /obj/machinery/slashco_generator(GeneratorTwo)
	var/GeneratorThree = pick(GLOB.genstart)
	GLOB.genstart -= GeneratorThree
	new /obj/machinery/slashco_generator(GeneratorThree)

/proc/spawn_slashco_sheets()
	for(var/integer=1 to 24) // Double the sheets you'll need
		var/OurSheet = pick(GLOB.sheetstart)
		GLOB.sheetstart -= OurSheet
		new /obj/item/stack/sheet/mineral/plasma

/datum/antagonist/slasher/test_slasher
	name = "Testy The Test Slasher"
