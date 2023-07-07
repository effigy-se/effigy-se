#define TESHARI_TEMP_OFFSET -30 // K, added to comfort/damage limit etc
#define TESHARI_BURNMOD 1.25 // They take more damage from practically everything
#define TESHARI_BRUTEMOD 1.2
#define TESHARI_HEATMOD 1.3
#define TESHARI_COLDMOD 0.67 // Except cold.

/datum/species/teshari
	name = "Teshari"
	id = SPECIES_TESHARI
	eyes_icon = 'local/icons/obj/medical/organs/teshari_eyes.dmi'
	inherent_traits = list(
		TRAIT_HAS_MARKINGS,
		TRAIT_NO_UNDERWEAR,
		TRAIT_MUTANT_COLORS,
		TRAIT_TACKLING_FRAIL_ATTACKER,
	)
	mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"ears" = ACC_RANDOM,
		"legs" = "Normal Legs"
	)
	digitigrade_customization = DIGITIGRADE_NEVER
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	payday_modifier = 1
	custom_worn_icons = list(
		LOADOUT_ITEM_HEAD = TESHARI_HEAD_ICON,
		LOADOUT_ITEM_MASK = TESHARI_MASK_ICON,
		LOADOUT_ITEM_NECK = TESHARI_NECK_ICON,
		LOADOUT_ITEM_SUIT = TESHARI_SUIT_ICON,
		LOADOUT_ITEM_UNIFORM = TESHARI_UNIFORM_ICON,
		LOADOUT_ITEM_HANDS =  TESHARI_HANDS_ICON,
		LOADOUT_ITEM_SHOES = TESHARI_FEET_ICON,
		LOADOUT_ITEM_GLASSES = TESHARI_EYES_ICON,
		LOADOUT_ITEM_BELT = TESHARI_BELT_ICON,
		LOADOUT_ITEM_MISC = TESHARI_BACK_ICON,
		LOADOUT_ITEM_ACCESSORY = TESHARI_ACCESSORIES_ICON,
		LOADOUT_ITEM_EARS = TESHARI_EARS_ICON
	)
	coldmod = TESHARI_COLDMOD
	heatmod = TESHARI_HEATMOD
	bodytemp_normal = BODYTEMP_NORMAL + TESHARI_TEMP_OFFSET
	bodytemp_heat_damage_limit = (BODYTEMP_HEAT_DAMAGE_LIMIT + TESHARI_TEMP_OFFSET)
	bodytemp_cold_damage_limit = (BODYTEMP_COLD_DAMAGE_LIMIT + TESHARI_TEMP_OFFSET)
	species_language_holder = /datum/language_holder/teshari
	body_size_restricted = TRUE
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/teshari,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/teshari,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/teshari,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/teshari,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/teshari,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/teshari,
	)

/datum/species/teshari/random_name(gender, unique, lastname)
	if(unique)
		return random_unique_teshari_name()

	var/randname = teshari_name()

	if(lastname)
		randname += " [lastname]"

	return randname

/datum/species/teshari/prepare_human_for_preview(mob/living/carbon/human/tesh)
	var/base_color = "#c0965f"
	var/ear_color = "#e4c49b"

	tesh.dna.features["mcolor"] = base_color
	tesh.dna.mutant_bodyparts["ears"] = list(MUTANT_INDEX_NAME = "Teshari Feathers Upright", MUTANT_INDEX_COLOR_LIST = list(ear_color, ear_color, ear_color))
	tesh.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Teshari (Default)", MUTANT_INDEX_COLOR_LIST = list(base_color, base_color, ear_color))
	regenerate_organs(tesh, src, visual_only = TRUE)
	tesh.update_body(TRUE)

#define MASK_SNOUT_EXTRA_OFFSET_X 1
#define MASK_SNOUT_EXTRA_OFFSET_Y 1

/obj/item
	var/datum/greyscale_config/greyscale_config_worn_teshari_fallback
	var/datum/greyscale_config/greyscale_config_worn_teshari_fallback_skirt

/datum/species/teshari/get_custom_worn_icon(item_slot, obj/item/item)
	return item.worn_icon_teshari

/datum/species/teshari/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_teshari = icon

/datum/species/teshari/get_custom_worn_config_fallback(item_slot, obj/item/item)
	// skirt support
	if(istype(item, /obj/item/clothing/under) && !(item.body_parts_covered & LEGS))
		return item.greyscale_config_worn_teshari_fallback_skirt

	return item.greyscale_config_worn_teshari_fallback

/datum/species/teshari/generate_custom_worn_icon(item_slot, obj/item/item, mob/living/carbon/human/human_owner)
	. = ..()
	if(.)
		return

	// Use the fancy fallback sprites.
	. = generate_custom_worn_icon_fallback(item_slot, item, human_owner)
	if(.)
		return

		// If there isn't even a fallback, use snouted sprites for masks and helmets, but offsetted
	if((item_slot == LOADOUT_ITEM_MASK || item_slot == LOADOUT_ITEM_HEAD) && (item.supports_variations_flags & CLOTHING_SNOUTED_VARIATION))
		var/obj/item/bodypart/head/my_head = human_owner.get_bodypart(BODY_ZONE_HEAD)
		var/datum/worn_feature_offset/selected_offset
		var/human_icon
		var/human_icon_state = item.worn_icon_state || item.icon_state
		if(item_slot == LOADOUT_ITEM_HEAD)

			human_icon = item.worn_icon_muzzled || SNOUTED_HEAD_FILE
			selected_offset = my_head?.worn_head_offset
		else
			human_icon = item.worn_icon_muzzled || SNOUTED_MASK_FILE
			selected_offset = my_head?.worn_mask_offset

		// Did the snout variation flag lie to us?
		if(!icon_exists(human_icon, human_icon_state))
			return

		// Use already resolved icon
		use_custom_worn_icon_cached()
		var/icon/cached_icon = get_custom_worn_icon_cached(human_icon, human_icon_state, "m")
		if(cached_icon)
			return cached_icon

		// Generate muzzled icon, but offset
		var/icon/new_icon = icon('icons/blanks/32x32.dmi', "nothing")
		selected_offset?.apply_offset(new_icon)
		new_icon.Blend(icon(human_icon, human_icon_state), ICON_OVERLAY)
		new_icon.Insert(new_icon, human_icon_state)
		set_custom_worn_icon_cached(human_icon, human_icon_state, "m", new_icon)
		return new_icon

#undef MASK_SNOUT_EXTRA_OFFSET_X
#undef MASK_SNOUT_EXTRA_OFFSET_Y
