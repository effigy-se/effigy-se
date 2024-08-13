/datum/reagent/consumable/piru_flour
	name = "Piru Flour"
	description = "Flour made from ground piru fronds, it seems to clump together with itself."
	nutriment_factor = 4 * REAGENTS_METABOLISM
	color = "#c499bc"
	taste_description = "chalky, sweet flour"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/kiri_jelly
	name = "Kiri Jelly"
	description = "Sticky, sweet jelly from ground kiri fruits. It almost seems to sparkle by itself."
	nutriment_factor = 10 * REAGENTS_METABOLISM
	color = "#993c5c"
	taste_mult = 2
	taste_description = "ultra-sweet jelly"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/muli_juice
	name = "Muli Juice"
	description = "A pale-blue liquid contained inside muli pods. Widely used in teshari cuisine."
	nutriment_factor = 4 * REAGENTS_METABOLISM
	color = "#6f83a6"
	taste_mult = 2
	taste_description = "mintyness"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/nakati_spice
	name = "Nakati Spice"
	description = "A coarse brown powder ground from nakati bark which serves as a staple in teshari cooking. The aroma is delightful, but extremely potent."
	nutriment_factor = 2 * REAGENTS_METABOLISM
	color = "#735c45"
	taste_mult = 3
	taste_description = "potent seasoning"
	chemical_flags = REAGENT_CAN_BE_SYNTHESIZED

/datum/reagent/consumable/nutriment/tungsten
	name = "Tungsten"
	description = "When consumed by synthetics, this silvery metal transforms even the most stoic synths into adorable, joyful companions!"
	color = "#62708A"
	taste_description = "beeps and boops"
	nutriment_factor = 18
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	brute_heal = 0
	burn_heal = 0

/datum/reagent/consumable/nutriment/tungsten/on_mob_life(mob/living/carbon/synth)
	if(!issynthetic(synth))
		return 0 // not one of your human vitamins and minerals

	if(prob(40))
		to_chat(synth, span_notice("[pick("SYNTH_TUNGSTEN_TEXT_1", "SYNTH_TUNGSTEN_TEXT_2", "SYNTH_TUNGSTEN_TEXT_3")]"))
	else if(prob(40))
		to_chat(synth, span_notice("[pick("SYNTH_TUNGSTEN_TEXT_4", "SYNTH_TUNGSTEN_TEXT_5", "SYNTH_TUNGSTEN_TEXT_6")]"))
	else
		synth.emote(pick("beep", "beep2", "dwoop"))

	return ..()
