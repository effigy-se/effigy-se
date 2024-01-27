/datum/species/aquatic
	name = "Aquatic"
	id = SPECIES_AQUATIC
	inherent_traits = list(
		TRAIT_MUTANT_COLORS,
		TRAIT_WATER_BREATHING,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"snout" = ACC_RANDOM,
		"ears" = ACC_RANDOM,
		"legs" = "Normal Legs",
		"frills" = "None",
		"horns" = "None",
		"spines" = "None",
		"wings" = "None",
	)
	payday_modifier = 1
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_AKULA
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/akula,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/akula,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/akula,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/akula,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/akula,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/akula,
	)

/datum/species/aquatic/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Shark", TRUE),
		"snout" = list("Shark", TRUE),
		"horns" = list("None", FALSE),
		"ears" = list("Hammerhead", TRUE),
		"legs" = list("Normal Legs", FALSE),
		"wings" = list("None", FALSE),
	)

/datum/species/aquatic/randomize_features(mob/living/carbon/human/human_mob)
	var/list/features = ..()
	var/main_color
	var/second_color
	var/random = rand(1,5)
	//Choose from a variety of sharkish colors, with a whiter secondary and tertiary
	switch(random)
		if(1)
			main_color = "#668899"
			second_color = "#BBCCDD"
		if(2)
			main_color = "#334455"
			second_color = "#DDDDEE"
		if(3)
			main_color = "#445566"
			second_color = "#DDDDEE"
		if(4)
			main_color = "#666655"
			second_color = "#DDDDEE"
		if(5)
			main_color = "#444444"
			second_color = "#DDDDEE"
	features["mcolor"] = main_color
	features["mcolor2"] = second_color
	features["mcolor3"] = second_color

/datum/species/aquatic/get_random_body_markings(list/passed_features)
	var/name = "Shark"
	var/datum/body_marking_set/BMS = GLOB.body_marking_sets[name]
	var/list/markings = list()
	if(BMS)
		markings = assemble_body_markings_from_set(BMS, passed_features, src)
	return markings

/datum/species/aquatic/get_species_description()
	return placeholder_description

/datum/species/aquatic/get_species_lore()
	return list(placeholder_lore)
