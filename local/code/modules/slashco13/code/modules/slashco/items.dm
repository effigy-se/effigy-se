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
	desc = "Now cleared for sale in the Victus-Gyravi Sector! Is it worth it?"
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
	SSpoints_of_interest.make_point_of_interest(src)

/obj/item/step_decoy/Destroy(force)
	. = ..()
	QDEL_NULL(our_fake_steps)

/datum/looping_sound/decoy_footstep
	mid_sounds = list(
		'sound/effects/footstep/floor1.ogg' = 1, \
		'sound/effects/footstep/floor2.ogg' = 1, \
		'sound/effects/footstep/floor3.ogg' = 1, \
		'sound/effects/footstep/floor4.ogg' = 1, \
		'sound/effects/footstep/floor5.ogg' = 1, \
	)
	mid_length = 0.5 SECONDS
	extra_range = SOUND_RANGE // we want these to be actually... hearable; easily

/*
	DEVIL DIE
*/

/obj/item/dice/d6/devil_die
	name = "devil die"
	desc = span_cult("I've a bargain for you...")

/obj/item/dice/d6/devil_die/Initialize(mapload)
	. = ..()
	SSpoints_of_interest.make_point_of_interest(src)

/obj/item/dice/d6/devil_die/diceroll(mob/user, in_hand=FALSE)
	. = ..()
	var/turf/selected_turf = get_turf(src)
	selected_turf.visible_message(span_userdanger("[src] flares briefly."))

	addtimer(CALLBACK(src, PROC_REF(effect), user, .), 1 SECONDS)

/obj/item/dice/d6/devil_die/proc/effect(mob/living/carbon/human/user,roll)
	if(!istype(user))
		return // don't want to waste this by fluke
	switch(roll)
		if(1)
			// You're winner! Two pieces of fuel
			var/turf/stepped_turf = get_step(get_turf(user), user.dir)
			playsound(src, 'local/code/modules/slashco13/sound/items/devildie_fuel.ogg', 100)
			for(var/integer=1 to 2)
				var/our_new_fuel = new /obj/item/stack/fuel(stepped_turf)
				var/datum/effect_system/spark_spread/quantum/sparks = new
				sparks.set_up(10, 1, our_new_fuel)
				sparks.attach(get_turf(our_new_fuel))
				sparks.start()
		if(2)
			// Speed bonus
			playsound(src, 'local/code/modules/slashco13/sound/items/devildie_speed.ogg', 100)
			user.apply_status_effect(/datum/status_effect/lobster_rush/extended/slashco)
		if(3)
			// Heal
			playsound(src, 'local/code/modules/slashco13/sound/items/devildie_heal.ogg', 100)
			user.heal_overall_damage(rand(1,100), rand(1,100))
		if(4)
			// Hurt
			playsound(src, 'local/code/modules/slashco13/sound/items/devildie_hurt.ogg', 100)
			user.apply_damage(rand(1,100), pick(BRUTE, BURN))
		if(5)
			// Siren
			SSslashco.devil_die_siren_setup(user)
		if(6)
			// KILL
			playsound(src, 'local/code/modules/slashco13/sound/items/devildie_kill.ogg', 100)
			lightningbolt(user)
			user.gib()
	playsound(src, 'sound/items/ceramic_break.ogg', 50) // one of the few times I've opted not to port SFX
	visible_message(span_warning("[src] breaks apart as it reveals it rolled a [roll]!"))
	new /obj/item/plate_shard(get_turf(src))
	qdel(src)

/datum/status_effect/lobster_rush/extended/slashco
	duration = 45 SECONDS // RUN FORREST RUN

/*
	POCKET SAND NYEHEHEHEH
*/

/obj/item/pocket_sand
	name = "pocket sand"
	desc = "For blinding your enemies and running off mischeviously."
	icon = 'icons/obj/toys/dice.dmi'
	icon_state = "dicebag"
	gender = PLURAL

/obj/item/pocket_sand/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	var/datum/effect_system/fluid_spread/smoke/bad/smoke = new
	smoke.set_up(4, holder = src, location = get_turf(src))
	smoke.start()
	qdel(smoke)
	qdel(src)

/obj/item/pocket_sand/Initialize(mapload)
	. = ..()
	SSpoints_of_interest.make_point_of_interest(src)
