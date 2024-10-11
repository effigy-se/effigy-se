/obj/effect/landmark/slashco_item_spawn
	name = "SlashCo Item spawn"
	icon_state = "x2"

/obj/effect/landmark/slashco_item_spawn/Initialize(mapload)
	..()
	GLOB.slashitemstart += loc
	return INITIALIZE_HINT_QDEL

/*
B-GONE SODA
*/

/obj/item/reagent_containers/cup/soda_cans/b_gone
	name = "B-Gone Soda"
	desc = "This highly illegal \"drink\" is merely repackaged SaturnX for the commerical market. How this got here is a mystery."
	list_reagents = list(/datum/reagent/drug/saturnx = 30)
	drink_type = SUGAR | JUNKFOOD | TOXIC
	pickup_sound = 'local/code/modules/slashco13/sound/items/pickup.ogg'
	drop_sound = 'local/code/modules/slashco13/sound/items/drop.ogg'

/obj/item/reagent_containers/cup/soda_cans/b_gone/Initialize(mapload)
	. = ..()
	SSpoints_of_interest.make_point_of_interest(src)

/*
	LAB GROWN MEAT
*/

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
	pickup_sound = 'local/code/modules/slashco13/sound/items/pickup.ogg'
	drop_sound = 'local/code/modules/slashco13/sound/items/drop.ogg'
	preserved_food = TRUE

/obj/item/food/meat/lab_grown/Initialize(mapload)
	. = ..()
	SSpoints_of_interest.make_point_of_interest(src)

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

/*
MAYO
*/
/obj/item/reagent_containers/condiment/mayonnaise/slashco
	pickup_sound = 'local/code/modules/slashco13/sound/items/pickup.ogg'
	drop_sound = 'local/code/modules/slashco13/sound/items/drop.ogg'

/obj/item/reagent_containers/condiment/mayonnaise/slashco
	list_reagents = list(/datum/reagent/medicine/adminordrazine = 5)

/obj/item/reagent_containers/condiment/mayonnaise/slashco/Initialize(mapload)
	. = ..()
	SSpoints_of_interest.make_point_of_interest(src)

/*
	STEP DECOY
*/
/obj/item/step_decoy
	name = "step decoy"
	desc = "For sneaking out at night to make bad decisions."
	icon = /obj/item/clothing/shoes/workboots::icon
	icon_state = /obj/item/clothing/shoes/workboots::icon_state
	righthand_file = /obj/item/clothing/shoes/workboots::righthand_file
	lefthand_file = /obj/item/clothing/shoes/workboots::lefthand_file
	inhand_icon_state = /obj/item/clothing/shoes/workboots::inhand_icon_state
	var/datum/looping_sound/decoy_footstep/our_fake_steps

/obj/item/step_decoy/Initialize(mapload)
	. = ..()
	our_fake_steps = new
	our_fake_steps.start(src)

/obj/item/step_decoy/Destroy(force)
	. = ..()
	QDEL_NULL(our_fake_steps)

/datum/looping_sound/decoy_footstep
	mid_sounds = list(
		'sound/effects/footstep/floor1.ogg', \
		'sound/effects/footstep/floor2.ogg', \
		'sound/effects/footstep/floor3.ogg', \
		'sound/effects/footstep/floor4.ogg', \
		'sound/effects/footstep/floor5.ogg', \
	)
