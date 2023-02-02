/// Common Slasher Antag Handling Here ///
/datum/antagonist/slasher
	name = "Slasher"
	roundend_category = "slashers"
	job_rank = ROLE_SLASHER
	suicide_cry = "GAME SUCK I GO BED!!"
	antagpanel_category = "Slashers"
	show_to_ghosts = TRUE
	var/mob_type = /mob/living/carbon/human

/// TODO: Preview Icon Here

/datum/antagonist/slasher/on_gain()
	. = ..()
	if(!GLOB.generators_spawned)
		spawn_slashco_generators()
		spawn_slashco_sheets()
		spawn_slashco_batteries()
	equip_slasher()

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

/datum/antagonist/slasher/proc/equip_slasher(var/OurSlasher = owner.current)
	if(mob_type != /mob/living/carbon/human)
		var/mob/SlasherToBe = OurSlasher
		SlasherToBe.change_mob_type(mob_type, null, null, TRUE)
	give_slasher_abilities(OurSlasher)

/datum/antagonist/slasher/proc/give_slasher_abilities()
