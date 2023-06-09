#define MINIMUM_CLOTHING_STOCK 5

/obj/machinery/vending
	/// Additions to the `products` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/effigy_products
	/// Additions to the `product_categories` list of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/effigy_product_categories
	/// Additions to the `premium` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/effigy_premium
	/// Additions to the `contraband` list  of the vending machine, modularly. Will become null after Initialize, to free up memory.
	var/list/effigy_contraband

/obj/machinery/vending/Initialize(mapload)
	if(effigy_products)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in effigy_products)
			products[item_to_add] = effigy_products[item_to_add]

	if(effigy_product_categories)
		for(var/category in effigy_product_categories)
			var/already_exists = FALSE
			for(var/existing_category in product_categories)
				if(existing_category["name"] == category["name"])
					existing_category["products"] += category["products"]
					already_exists = TRUE
					break

			if(!already_exists)
				product_categories += category

	if(effigy_premium)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in effigy_premium)
			premium[item_to_add] = effigy_premium[item_to_add]

	if(effigy_contraband)
		// We need this, because duplicates screw up the spritesheet!
		for(var/item_to_add in effigy_contraband)
			contraband[item_to_add] = effigy_contraband[item_to_add]

	// Time to make clothes amounts consistent!
	for (var/obj/item/clothing/item in products)
		if(products[item] < MINIMUM_CLOTHING_STOCK && allow_increase(item))
			products[item] = MINIMUM_CLOTHING_STOCK

	for (var/category in product_categories)
		for(var/obj/item/clothing/item in category["products"])
			if(category["products"][item] < MINIMUM_CLOTHING_STOCK && allow_increase(item))
				category["products"][item] = MINIMUM_CLOTHING_STOCK

	for (var/obj/item/clothing/item in premium)
		if(premium[item] < MINIMUM_CLOTHING_STOCK && allow_increase(item))
			premium[item] = MINIMUM_CLOTHING_STOCK

	QDEL_NULL(effigy_products)
	QDEL_NULL(effigy_product_categories)
	QDEL_NULL(effigy_premium)
	QDEL_NULL(effigy_contraband)
	return ..()

/// This proc checks for forbidden traits cause it'd be pretty bad to have 5 insuls available to assistants roundstart at the vendor!
/obj/machinery/vending/proc/allow_increase(obj/item/clothing/clothing_path)
	var/obj/item/clothing/clothing = new clothing_path()

	// Ignore earmuffs!
	if(TRAIT_DEAF in clothing.clothing_traits)
		return FALSE
	// Don't touch sunglasses or welding helmets!
	if(clothing.flash_protect == FLASH_PROTECTION_WELDER)
		return FALSE
	// Don't touch bodyarmour!
	if(ispath(clothing, /obj/item/clothing/suit/armor))
		return FALSE
	// Don't touch protective helmets, like riot helmets!
	if(ispath(clothing, /obj/item/clothing/head/helmet))
		return FALSE
	// Ignore all gloves, because it's almost impossible to check what they do...
	if(ispath(clothing, /obj/item/clothing/gloves))
		return FALSE
	return TRUE

#undef MINIMUM_CLOTHING_STOCK
