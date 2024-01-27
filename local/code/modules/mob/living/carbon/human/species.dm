/**
 * # species datum
 *
 * Datum that handles different species in the game.
 *
 * This datum handles species in the game, such as lizardpeople, mothmen, zombies, skeletons, etc.
 * It is used in [carbon humans][mob/living/carbon/human] to determine various things about them, like their food preferences, if they have biological genders, their damage resistances, and more.
 *
 */
GLOBAL_LIST_EMPTY(customizable_races)

/datum/species
	mutant_bodyparts = list()
	digitigrade_customization = DIGITIGRADE_OPTIONAL // Doing this so that the legs preference actually works for everyone.
	/// Adding a language type to this in the form of /datum/language will allow the language to be displayed in preferences for that species, even if it is a secret language.
	/// Currently used for ashtongue in ashwalkers.
	var/list/language_prefs_whitelist
	///Self explanatory
	var/can_have_genitals = TRUE
	///A list of actual body markings on the owner of the species. Associative lists with keys named by limbs defines, pointing to a list with names and colors for the marking to be rendered. This is also stored in the DNA
	var/list/list/body_markings = list()
	///Override of the eyes icon file, used for Vox and maybe more in the future - The future is now, with Teshari using it too
	var/eyes_icon
	///How are we treated regarding processing reagents, by default we process them as if we're organic
	var/reagent_flags = PROCESS_ORGANIC
	///Whether a species can use augmentations in preferences
	var/can_augment = TRUE
	///Override for the alpha of bodyparts and mutant parts.
	var/specific_alpha = 255
	///Override for alpha value of markings, should be much lower than the above value.
	var/markings_alpha = 255
	///If a species can always be picked in prefs for the purposes of customizing it for ghost roles or events
	var/always_customizable = FALSE
	/// If a species requires the player to be a Veteran to be able to pick it.
	var/veteran_only = FALSE
	///Flavor text of the species displayed on character creation screeen
	var/flavor_text = "No description."
		///Path to BODYTYPE_CUSTOM species worn icons. An assoc list of ITEM_SLOT_X => /icon
	var/list/custom_worn_icons = list()
	///Is this species restricted from changing their body_size in character creation?
	var/body_size_restricted = FALSE


/// Returns a list of the default mutant bodyparts, and whether or not they can be randomized or not
/datum/species/proc/get_default_mutant_bodyparts()
	return list()

/datum/species/proc/handle_mutant_bodyparts(mob/living/carbon/human/owner, forced_colour, force_update = FALSE)
	return

/datum/species/dullahan
	mutant_bodyparts = list()

/datum/species/human/felinid
	mutant_bodyparts = list()

/datum/species/human/felinid/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Cat", FALSE),
		"ears" = list("Cat", FALSE),
	)

/datum/species/human
	mutant_bodyparts = list()

/datum/species/human/get_default_mutant_bodyparts()
	return list(
		"ears" = list("None", FALSE),
		"tail" = list("None", FALSE),
		"wings" = list("None", FALSE),
	)

/datum/species/mush
	mutant_bodyparts = list()

/datum/species/vampire
	mutant_bodyparts = list()

/datum/species/plasmaman
	mutant_bodyparts = list()
	can_have_genitals = FALSE
	can_augment = FALSE

/datum/species/ethereal
	mutant_bodyparts = list()
	can_have_genitals = FALSE
	can_augment = FALSE

/datum/species/pod
	name = "Primal Podperson"
	always_customizable = TRUE

/datum/species/randomize_features(mob/living/carbon/human/human_mob)
	var/list/features = ..()
	return features

/**
 * Returns a list of mutant_bodyparts
 *
 * Gets the default species mutant_bodyparts list for the given species datum and sets up its sprite accessories.
 *
 * Arguments:
 * * features - Features are needed for the part color
 * * existing_mutant_bodyparts - When passed a list of existing mutant bodyparts, the existing ones will not get overwritten
 */
/datum/species/proc/get_mutant_bodyparts(list/features, list/existing_mutant_bodyparts) //Needs features to base the colour off of
	var/list/mutantpart_list = list()
	if(LAZYLEN(existing_mutant_bodyparts))
		mutantpart_list = existing_mutant_bodyparts.Copy()
	var/list/default_bodypart_data = GLOB.default_mutant_bodyparts[name]
	var/list/bodyparts_to_add = default_bodypart_data.Copy()
	if(CONFIG_GET(flag/disable_erp_preferences))
		for(var/genital in GLOB.possible_genitals)
			bodyparts_to_add.Remove(genital)
	for(var/key in bodyparts_to_add)
		if(LAZYLEN(existing_mutant_bodyparts) && existing_mutant_bodyparts[key])
			continue
		var/datum/sprite_accessory/SP
		if(default_bodypart_data[key][MUTANTPART_CAN_RANDOMIZE])
			SP = random_accessory_of_key_for_species(key, src)
		else
			SP = GLOB.sprite_accessories[key][bodyparts_to_add[key][MUTANTPART_NAME]]
			if(!SP)
				CRASH("Cant find accessory of [key] key, [bodyparts_to_add[key]] name, for species [id]")
		var/list/color_list = SP.get_default_color(features, src)
		var/list/final_list = list()
		final_list[MUTANT_INDEX_NAME] = SP.name
		final_list[MUTANT_INDEX_COLOR_LIST] = color_list
		mutantpart_list[key] = final_list

	return mutantpart_list

/datum/species/proc/get_random_body_markings(list/features) //Needs features to base the colour off of
	return list()

/datum/species/spec_stun(mob/living/carbon/human/H,amount)
	if(H)
		stop_wagging_tail(H)
	. = ..()

/*
*	TAIL WAGGING
*/

/datum/species/proc/can_wag_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/obj/item/organ/external/tail/T = H.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(!T)
		return FALSE
	if(T.can_wag)
		return TRUE
	return FALSE

/datum/species/proc/is_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return FALSE
	var/obj/item/organ/external/tail/T = H.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(!T)
		return FALSE
	return T.wagging

/datum/species/proc/start_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return
	var/obj/item/organ/external/tail/T = H.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(!T)
		return FALSE
	T.wagging = TRUE
	H.update_body()

/datum/species/proc/stop_wagging_tail(mob/living/carbon/human/H)
	if(!H) //Somewhere in the core code we're getting those procs with H being null
		return
	var/obj/item/organ/external/tail/T = H.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAIL)
	if(!T)
		return
	T.wagging = FALSE
	H.update_body()

/datum/species/regenerate_organs(mob/living/carbon/target, datum/species/old_species, replace_current = TRUE, list/excluded_zones, visual_only = FALSE)
	. = ..()

	var/robot_organs = (TRAIT_ROBOTIC_DNA_ORGANS in target.dna.species.inherent_traits)

	for(var/key in target.dna.mutant_bodyparts)
		if(!islist(target.dna.mutant_bodyparts[key]) || !(target.dna.mutant_bodyparts[key][MUTANT_INDEX_NAME] in GLOB.sprite_accessories[key]))
			continue

		var/datum/sprite_accessory/mutant_accessory = GLOB.sprite_accessories[key][target.dna.mutant_bodyparts[key][MUTANT_INDEX_NAME]]

		if(mutant_accessory?.factual && mutant_accessory.organ_type)
			var/obj/item/organ/current_organ = target.get_organ_by_type(mutant_accessory.organ_type)

			if(!current_organ || replace_current)
				var/obj/item/organ/replacement = SSwardrobe.provide_type(mutant_accessory.organ_type)
				replacement.sprite_accessory_flags = mutant_accessory.flags_for_organ
				replacement.relevant_layers = mutant_accessory.relevent_layers

				if(robot_organs)
					replacement.organ_flags |= ORGAN_ROBOTIC

				// If there's an existing mutant organ, we're technically replacing it.
				// Let's abuse the snowflake proc that skillchips added. Basically retains
				// feature parity with every other organ too.
				if(current_organ)
					current_organ.before_organ_replacement(replacement)

				replacement.build_from_dna(target.dna, key)
				// organ.Insert will qdel any current organs in that slot, so we don't need to.
				replacement.Insert(target, special = TRUE, movement_flags = DELETE_IF_REPLACED)

			// var/obj/item/organ/path = new SA.organ_type
			// var/obj/item/organ/oldorgan = C.get_organ_slot(path.slot)
			// if(oldorgan)
			// 	oldorgan.Remove(C,TRUE)
			// 	QDEL_NULL(oldorgan)
			// path.build_from_dna(C.dna, key)
			// path.Insert(C, 0, FALSE)

/datum/species/proc/spec_revival(mob/living/carbon/human/H)
	return

/// Gets a list of all customizable races on roundstart.
/proc/get_customizable_races()
	RETURN_TYPE(/list)

	if (!GLOB.customizable_races.len)
		GLOB.customizable_races = generate_customizable_races()

	return GLOB.customizable_races

/**
 * Generates races available to choose in character setup at roundstart, yet not playable on the station.
 *
 * This proc generates which species are available to pick from in character setup.
 */
/proc/generate_customizable_races()
	var/list/customizable_races = list()

	for(var/species_type in subtypesof(/datum/species))
		var/datum/species/species = new species_type
		if(species.always_customizable)
			customizable_races += species.id
			qdel(species)

	return customizable_races
