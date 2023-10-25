/obj/item/food/meat/lab_grown
	name = "Lab-Grown Meat"
	desc = "Now cleared for sale in the Spinward Sector! Is it worth it?"
	icon_state = "meatproduct"
	color = "#e5ff00"
	food_reagents = list(
		/datum/reagent/consumable/nutriment/protein = 5,
		/datum/reagent/drug/therma_vision = 15,
		/datum/reagent/consumable/nutriment/vitamin = 1,
	)

/obj/item/food/meat/lab_grown/examine()
	. = ..()
	. += span_notice("Eating this should give you extra awareness of your surroundings... right?")

/datum/reagent/drug/therma_vision
	name = "Thermavision"
	description = "A rather useful chemical compound that enhances the senses. Unrelated to any synthetic alternatives."
	color = "#c54c13"
	taste_description = "paranoia on the back of your neck"
	penetrates_skin = NONE

/datum/reagent/drug/therma_vision/on_mob_metabolize(mob/living/the_mealer)
	. = ..()
	to_chat(the_mealer, span_nicegreen("You feel pins and needles behind your neck, and begin to pay attention to the world beyond."))
	if(the_mealer.has_status_effect(/datum/status_effect/grouped/stasis))
		return

	the_mealer.add_traits(list(TRAIT_XRAY_VISION), type)

/datum/reagent/drug/therma_vision/on_mob_end_metabolize(mob/living/carbon/the_mealer)
	. = ..()
	if(HAS_TRAIT_FROM(the_mealer, TRAIT_XRAY_VISION, type))
		the_mealer.remove_traits(list(TRAIT_XRAY_VISION), type)
		to_chat(the_mealer, span_notice("You feel almost relieved as things blur back into normality."))
