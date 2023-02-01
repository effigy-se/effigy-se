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
	spawn_slashco_generators()

/// This is unironically the worst piece of coding I've done for this project so far
/// And I look forward to some poor soul stumbling on this in a few months and weeping
/proc/spawn_slashco_generators()
	var/GeneratorOne = pick(GLOB.genstart)
	GeneratorOne -= GLOB.genstart
	new /obj/machinery/slashco_generator(GeneratorOne)
	var/GeneratorTwo = pick(GLOB.genstart)
	GeneratorTwo -= GLOB.genstart
	new /obj/machinery/slashco_generator(GeneratorTwo)
	var/GeneratorThree = pick(GLOB.genstart)
	GeneratorThree -= GLOB.genstart
	new /obj/machinery/slashco_generator(GeneratorThree)

/datum/antagonist/slasher/test_slasher
	name = "Testy The Test Slasher"
