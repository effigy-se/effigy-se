// Add modular crafting recipes here, NOT IN BASE /tg/ CRAFTING LISTS

/**
 * Add a list of receipes to an existing recipe sublist.
 *
 * Arguments:
 * * stack_recipes - the existing list of stack recipes.
 * * recipe_list_title - the title for the recipe list we're adding to
 * * appent_recipes - Add these recipes to the given recipe list.
 */
/proc/add_recipes_to_sublist(list/stack_recipes, recipe_list_title, list/append_recipes)
	for(var/datum/stack_recipe_list/sublist in stack_recipes)
		if(sublist.title != recipe_list_title)
			continue

		sublist.recipes += append_recipes
		return

	CRASH("Could not find recipe sublist [recipe_list_title] to add more recipes!")

// Iron

GLOBAL_LIST_INIT(effigy_metal_recipes, list(
	new/datum/stack_recipe("pool floor tile", /obj/item/stack/tile/iron/pool, 1, 1, 4, check_density = FALSE, category = CAT_TILES),
	new/datum/stack_recipe("lowered floor tile", /obj/item/stack/tile/iron/lowered, 1, 1, 4, check_density = FALSE, category = CAT_TILES),
	new/datum/stack_recipe("elevated floor tile", /obj/item/stack/tile/iron/elevated, 1, 1, 4, check_density = FALSE, category = CAT_TILES),
))

/obj/item/stack/sheet/iron/get_main_recipes()
	. = ..()
	. += GLOB.effigy_metal_recipes

// Wood

GLOBAL_LIST_INIT(effigy_wood_recipes, list(
	new/datum/stack_recipe("sauna oven", /obj/structure/sauna_oven, 30, time = 1.5 SECONDS, one_per_turf = TRUE, on_solid_ground = TRUE, category = CAT_ENTERTAINMENT),
))

/obj/item/stack/sheet/mineral/wood/get_main_recipes()
	. = ..()
	. += GLOB.effigy_wood_recipes

// Leather

GLOBAL_LIST_INIT(effigy_leather_belt_recipes, list(
	new/datum/stack_recipe("medical bandolier", /obj/item/storage/belt/medbandolier, 5, check_density = FALSE, category = CAT_CONTAINERS),
	new/datum/stack_recipe("gear harness", /obj/item/clothing/under/misc/skyrat/gear_harness, 6, check_density = FALSE, category = CAT_CLOTHING),
))

/obj/item/stack/sheet/leather/get_main_recipes()
	. = ..()
	add_recipes_to_sublist(., "belts", GLOB.effigy_leather_belt_recipes)
