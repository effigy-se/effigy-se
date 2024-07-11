/datum/species/mammal/slugcat
	name = "Slugcat Morph" //Called so because the species is so much more universal than just mammals
	id = SPECIES_SLUGCAT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/slugcat/eyes,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/slugcat,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/slugcat,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/slugcat,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/slugcat,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/slugcat,
	)
	species_language_holder = /datum/language_holder/slugcat

/datum/species/mammal/slugcat/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Slugcat", TRUE),
		"snout" = list("Slugcat", TRUE),
		"horns" = list("None", FALSE),
		"ears" = list("Slugcat", TRUE),
		"legs" = list("Digitigrade Legs", TRUE),
		"taur" = list("None", FALSE),
		"fluff" = list("None", FALSE),
		"frills" = list("Slugcat", TRUE),
		"wings" = list("None", FALSE),
		"head_acc" = list("None", FALSE),
		"neck_acc" = list("None", FALSE),
	)

/datum/species/mammal/slugcat/prepare_human_for_preview(mob/living/carbon/human/human)
	var/main_color = "#ffee66"
	var/secondary_color = "#ffaa66"
	human.dna.features["mcolor"] = main_color
	human.dna.features["mcolor2"] = secondary_color
	human.dna.features["mcolor3"] = secondary_color
	human.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Slugcat", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, "#464646"))
	human.dna.mutant_bodyparts["frills"] = list(MUTANT_INDEX_NAME = "Slugcat", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, "#464646"))
	human.dna.mutant_bodyparts["snout"] = list(MUTANT_INDEX_NAME = "Slugcat", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, "#4D4D4D"))
	human.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Slugcat", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, "#4D4D4D"))
	regenerate_organs(human, src, visual_only = TRUE)
	human.update_body(TRUE)

/datum/language_holder/slugcat
	understood_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
								/datum/language/slugcat = list(LANGUAGE_ATOM))
	spoken_languages = list(/datum/language/common = list(LANGUAGE_ATOM),
							/datum/language/slugcat = list(LANGUAGE_ATOM))

/datum/language/slugcat
	name = "Move-Speak"
	desc = "A primarily nonverbal language comprised of body movements, gesticulation, and sign language, with only intermittent vocalizations.  It's completely incomprehensible on vocalization alone."
	key = "M"
	flags = TONGUELESS_SPEECH
	space_chance = 30
	syllables = list(
		"wa", "wawa", "awa", "a"
	)
	icon = 'local/icons/misc/language.dmi'
	icon_state = "slugspeak"
	default_priority = 90

/*
* LIMBS AS AUGS ZONE
*/
/datum/augment_item/limb/head/slugcat
	name = "small-eyes slugcat head"
	path = /obj/item/bodypart/head/mutant/slugcat
	cost = 0
	uses_robotic_styles = FALSE
	uses_greyscale = TRUE

/datum/augment_item/limb/head/slugcat/eyes
	name = "big-eyes slugcat head"
	path = /obj/item/bodypart/head/mutant/slugcat/eyes

/datum/augment_item/limb/chest/slugcat
	name = "slugcat chest"
	path = /obj/item/bodypart/chest/mutant/slugcat
	cost = 0
	uses_robotic_styles = FALSE
	uses_greyscale = TRUE

/datum/augment_item/limb/l_arm/slugcat
	name = "slugcat left arm"
	path = /obj/item/bodypart/arm/left/mutant/slugcat
	cost = 0
	uses_robotic_styles = FALSE
	uses_greyscale = TRUE

/datum/augment_item/limb/r_arm/slugcat
	name = "slugcat right arm"
	path = /obj/item/bodypart/arm/right/mutant/slugcat
	cost = 0
	uses_robotic_styles = FALSE
	uses_greyscale = TRUE

/datum/augment_item/limb/l_leg/slugcat
	name = "slugcat left leg"
	path = /obj/item/bodypart/leg/left/mutant/slugcat
	cost = 0
	uses_robotic_styles = FALSE
	uses_greyscale = TRUE

/datum/augment_item/limb/r_leg/slugcat
	name = "slugcat right leg"
	path = /obj/item/bodypart/leg/right/mutant/slugcat
	cost = 0
	uses_robotic_styles = FALSE
	uses_greyscale = TRUE
