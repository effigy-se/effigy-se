#define REQUIRED_CROP_LIST_SIZE 4

/datum/preference/tri_color
	abstract_type = /datum/preference/tri_color
	var/type_to_check
	var/check_mode = TRICOLOR_CHECK_BOOLEAN

/datum/preference/tri_color/deserialize(input, datum/preferences/preferences)
	var/list/input_colors = input
	return list(sanitize_hexcolor(input_colors[1]), sanitize_hexcolor(input_colors[2]), sanitize_hexcolor(input_colors[3]))

/datum/preference/tri_color/create_default_value()
	return list("#[random_color()]", "#[random_color()]", "#[random_color()]")

/datum/preference/tri_color/is_valid(list/value)
	return islist(value) && value.len == 3 && (findtext(value[1], GLOB.is_color) && findtext(value[2], GLOB.is_color) && findtext(value[3], GLOB.is_color))

/datum/preference/tri_color/is_accessible(datum/preferences/preferences)
	if (check_mode == TRICOLOR_NO_CHECK || type == abstract_type)
		return ..(preferences)
	var/passed_initial_check = ..(preferences)
	var/part_enabled = preferences.read_preference(type_to_check)
	if(check_mode == TRICOLOR_CHECK_ACCESSORY)
		part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, part_enabled)
	return (passed_initial_check && part_enabled)

/datum/preference/tri_color/apply_to_human(mob/living/carbon/human/target, value)
	if (type == abstract_type)
		return ..()
	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))
	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_COLOR_LIST] = list(sanitize_hexcolor(value[1]), sanitize_hexcolor(value[2]), sanitize_hexcolor(value[3]))

/datum/preference/tri_bool
	abstract_type = /datum/preference/tri_bool
	var/type_to_check
	var/check_mode = TRICOLOR_CHECK_BOOLEAN

/datum/preference/tri_bool/deserialize(input, datum/preferences/preferences)
	var/list/input_bools = input
	return list(sanitize_integer(input_bools[1]), sanitize_integer(input_bools[2]), sanitize_integer(input_bools[3]))

/datum/preference/tri_bool/create_default_value()
	return list(FALSE, FALSE, FALSE)

/datum/preference/tri_bool/is_valid(list/value)
	return islist(value) && value.len == 3 && isnum(value[1]) && isnum(value[2]) && isnum(value[3])

/datum/preference/tri_bool/is_accessible(datum/preferences/preferences)
	if(type == abstract_type)
		return ..(preferences)
	var/passed_initial_check = ..(preferences)
	var/emissives_allowed = preferences.read_preference(/datum/preference/toggle/allow_emissives)
	var/part_enabled = preferences.read_preference(type_to_check)
	if(check_mode == TRICOLOR_CHECK_ACCESSORY)
		part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, part_enabled)
	return (passed_initial_check && part_enabled && emissives_allowed)

/datum/preference/tri_bool/proc/is_emissive_allowed(datum/preferences/preferences)
	return preferences?.read_preference(/datum/preference/toggle/allow_emissives)

/datum/preference/tri_bool/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if (type == abstract_type)
		return ..()
	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))
	if(is_emissive_allowed(preferences))
		target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_EMISSIVE_LIST] = list(sanitize_integer(value[1]), sanitize_integer(value[2]), sanitize_integer(value[3]))

/datum/preference/color/mutant
	abstract_type = /datum/preference/color/mutant

/datum/preference/color/mutant/apply_to_human(mob/living/carbon/human/target, value)
	if (type == abstract_type)
		return ..()

	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))

	var/color_value = sanitize_hexcolor(value)
	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_COLOR_LIST] = list(color_value, color_value, color_value)

/**
 * Base class for character feature togglers
 */
/datum/preference/toggle/mutant_toggle
	abstract_type = /datum/preference/toggle/mutant_toggle
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	default_value = FALSE

	/// The linked preferences to this toggle. Automatically filled.
	var/list/linked_preference_paths = list()

/datum/preference/toggle/mutant_toggle/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return TRUE // we dont actually want this to do anything

/datum/preference/toggle/mutant_toggle/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	return passed_initial_check

/**
 * Base class for choices character features, mainly mutant body parts
 */
/datum/preference/choiced/mutant_choice
	abstract_type = /datum/preference/choiced/mutant_choice
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER

	/// Path to the default sprite accessory
	var/datum/sprite_accessory/default_accessory_type = /datum/sprite_accessory/blank
	/// Path to the corresponding /datum/preference/toggle to check if part is enabled.
	var/datum/preference/toggle/type_to_check
	/// Generates icons from the provided mutant bodypart for use in icon-enabled selection boxes in the prefs window.
	var/generate_icons = FALSE
	/// A list of the four co-ordinates to crop to, if `generate_icons` is enabled. Useful for icons whose main contents are smaller than 32x32. Please keep it square.
	var/list/crop_area
	/// A color to apply to the icon if it's greyscale, and `generate_icons` is enabled.
	var/greyscale_color

/datum/preference/choiced/mutant_choice/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/part_enabled = is_part_enabled(preferences)
	return (passed_initial_check && part_enabled)

// icons are cached
/datum/preference/choiced/mutant_choice/icon_for(value)
	if(!should_generate_icons)
		// because of the way the unit tests are set up, we need this to crash here
		CRASH("`icon_for()` was not implemented for [type], even though should_generate_icons = TRUE!")

	var/list/cached_icons = get_choices()
	return cached_icons[value]

/// Allows for dynamic assigning of icon states.
/datum/preference/choiced/mutant_choice/proc/generate_icon_state(datum/sprite_accessory/sprite_accessory, original_icon_state)
	return original_icon_state

/// Generates and allows for post-processing on icons, such as greyscaling and cropping. This is cached.
/datum/preference/choiced/mutant_choice/proc/generate_icon(datum/sprite_accessory/sprite_accessory)
	if(!sprite_accessory.icon_state)
		return icon('icons/mob/landmarks.dmi', "x")

	var/icon/icon_to_process = icon(sprite_accessory.icon, generate_icon_state(sprite_accessory, sprite_accessory.icon_state), SOUTH, 1)

	if(islist(crop_area) && crop_area.len == REQUIRED_CROP_LIST_SIZE)
		icon_to_process.Crop(crop_area[1], crop_area[2], crop_area[3], crop_area[4])
		icon_to_process.Scale(32, 32)
	else if(crop_area)
		stack_trace("Invalid crop paramater! The provided crop area list is not four entries long, or is not a list!")

	var/color = sanitize_hexcolor(greyscale_color)
	if(color && sprite_accessory.color_src)
		// This isn't perfect, but I don't want to add the significant overhead to make it be.
		icon_to_process.ColorTone(color)

	return icon_to_process

/datum/preference/choiced/mutant_choice/init_possible_values()
	if(!initial(generate_icons))
		return assoc_to_keys_features(GLOB.sprite_accessories[relevant_mutant_bodypart])

	var/list/list_of_accessories = list()
	for(var/sprite_accessory_name as anything in GLOB.sprite_accessories[relevant_mutant_bodypart])
		var/datum/sprite_accessory/sprite_accessory = GLOB.sprite_accessories[relevant_mutant_bodypart][sprite_accessory_name]
		list_of_accessories += list("[sprite_accessory.name]" = generate_icon(sprite_accessory))

	return list_of_accessories

/datum/preference/choiced/mutant_choice/create_default_value()
	return initial(default_accessory_type.name)

/**
 * Is this part enabled by the player?
 *
 * Arguments:
 * * preferences - The relevant character preferences.
 */
/datum/preference/choiced/mutant_choice/proc/is_part_enabled(datum/preferences/preferences)
	return preferences.read_preference(type_to_check)

/**
 * Actually rendered. Slimmed down version of the logic in is_available() that actually works when spawning or drawing the character.
 *
 * Returns TRUE if feature is visible.
 *
 * Arguments:
 * * target - The character this is being applied to.
 * * preferences - The relevant character preferences.
 */
/datum/preference/choiced/mutant_choice/proc/is_visible(mob/living/carbon/human/target, datum/preferences/preferences)
	if(!is_part_enabled(preferences))
		return FALSE

	return TRUE

/// Apply this preference onto the given human.
/// May be overriden by subtypes.
/// Called when the savefile_identifier == PREFERENCE_CHARACTER.
///
/// Returns whether the bodypart is actually visible.
/datum/preference/choiced/mutant_choice/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	// body part is not the default/none value.
	var/bodypart_is_visible = preferences && is_visible(target, preferences)

	if(!bodypart_is_visible)
		value = create_default_value()

	if(value == "None")
		return bodypart_is_visible

	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = value, MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))
		return bodypart_is_visible

	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_NAME] = value
	return bodypart_is_visible

/datum/preference/toggle/emissive
	abstract_type = /datum/preference/toggle/emissive
	/// Path to the corresponding /datum/preference/toggle to check if part is enabled.
	var/type_to_check
	/// Can either be `TRICOLOR_CHECK_BOOLEAN` or `TRICOLOR_CHECK_ACCESSORY`, the latter of which adding an extra check to make sure the accessory is enabled and a factual accessory, aka not None
	var/check_mode = TRICOLOR_CHECK_BOOLEAN

/datum/preference/toggle/emissive/is_accessible(datum/preferences/preferences)
	if(type == abstract_type)
		return ..(preferences)
	var/emissives_allowed = preferences.read_preference(/datum/preference/toggle/allow_emissives)
	var/part_enabled = preferences.read_preference(type_to_check)
	if(check_mode == TRICOLOR_CHECK_ACCESSORY)
		part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, part_enabled)
	return (part_enabled && emissives_allowed)

/datum/preference/toggle/emissive/apply_to_human(mob/living/carbon/human/target, value)
	if (type == abstract_type)
		return ..()
	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))
	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_EMISSIVE_LIST] = list(sanitize_integer(value), sanitize_integer(value), sanitize_integer(value))

#undef REQUIRED_CROP_LIST_SIZE

//We want players to be able to decide whether they show up in the directory or not
/datum/preference/toggle/show_in_directory
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	default_value = TRUE
	savefile_key = "show_in_directory"
	savefile_identifier = PREFERENCE_PLAYER

//The advertisement that you show to people looking through the directory
/datum/preference/text/character_ad
	savefile_key = "character_ad"
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	maximum_value_length = MAX_FLAVOR_LEN

//TGUI gets angry if you don't define a default on text preferences
/datum/preference/text/character_ad/create_default_value()
	return ""

//Any text preference needs this for some reason
/datum/preference/text/character_ad/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/attraction
	savefile_key = "attraction"
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/attraction/init_possible_values()
	return list("Gay", "Lesbian", "Straight", "Skolio", "Bi", "Pan", "Poly", "Omni", "Ace", "Unset", "Check OOC")

/datum/preference/choiced/attraction/create_default_value()
	return "Unset"

/datum/preference/choiced/attraction/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/display_gender
	savefile_key = "display_gender"
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/display_gender/init_possible_values()
	return list("Male", "Female", "Null", "Plural", "Nonbinary", "Omni", "Trans", "Andro", "Gyno", "Fluid", "Unset", "Check OOC")

/datum/preference/choiced/display_gender/create_default_value()
	return "Unset"

/datum/preference/choiced/display_gender/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/obscure_on_examine
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	default_value = TRUE
	savefile_key = "obscure_on_examine"
	savefile_identifier = PREFERENCE_PLAYER
