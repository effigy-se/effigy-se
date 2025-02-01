#define DIG_UNDEFINED 	(1<<0) //when the scrap chunk is dug by an item with no dig depth.
#define DIG_DELETE 		(1<<1) //when the scrap chunk is dug too deep and gets destroyed in the process.
#define DIG_ROCK		(1<<2) //when the scrap chunk is just dug, with no additional effects.

#define BRUSH_DELETE	(2<<0) //when the scrap chunk is brushed and the scrap chunk gets destroyed.
#define BRUSH_UNCOVER	(2<<1) //when the scrap chunk is brushed and the scrap chunk reveals what it held.
#define BRUSH_NONE		(2<<2) //when the scrap chunk is brushed, with no additional effects.

#define REWARD_ONE 1
#define REWARD_TWO 2
#define REWARD_THREE 3

/obj/item/scrap_chunk
	name = "scrap chunk"
	desc = "A chunk of scrap, ready to be picked apart for something salvageable."
	icon = 'local/icons/obj/salvage.dmi'
	icon_state = "scrap_chunk"

	///The max depth a scrap chunk can be
	var/max_depth
	///The depth away/subtracted from the max_depth
	var/safe_depth
	//The depth chosen between the max and the max - safe depth
	var/item_depth
	//The depth that has been currently dug
	var/dug_depth = 0
	//The item that is hidden within the scrap chunk
	var/hidden_item
	///Whether the item has been measured, revealing the dug depth
	var/measured = FALSE
	///Whether the ite has been scanned, revealing the max and safe depth
	var/scanned = FALSE
	///Whether the ite has been advance scanned, revealing the true depth
	var/adv_scanned = FALSE
	///The tier of the item that was chosen, 1-100 then 1-3
	var/choose_tier
	/// Low-Value Rewards - ~61% Chance
	var/static/list/tier1_reward = list(
		/obj/item/stack/ore/iron/thirty = 20, \
		/obj/item/electronics/airalarm = 5, \
		/obj/item/electronics/airlock = 5, \
		/obj/item/electronics/firealarm = 5, \
		/obj/item/electronics/firelock = 5, \
		/obj/item/electronics/tracker = 4, \
		/obj/effect/spawner/random/bureaucracy/pen = 3, \
		/obj/effect/spawner/random/maintenance/no_decals = 2, \
		/obj/effect/spawner/random/contraband = 1, \
		/obj/effect/spawner/random/engineering/tool = 1, \
		/obj/effect/spawner/random/engineering/vending_restock = 1, \
	)
	/// High-Value Rewards - ~34% Chance
	var/static/list/tier2_reward = list(
		/obj/item/stack/ore/silver/thirty = 30, \
		/obj/item/stack/ore/titanium/thirty = 30, \
		/obj/item/stack/ore/plasma/thirty = 20, \
		/obj/item/stack/ore/diamond/ten = 10, \
		/obj/item/stack/ore/gold/twentyfive = 10, \
		/obj/item/salvage_handheld_scanner/advanced = 2, \
		/obj/item/salvaging_hammer/adv = 2, \
		/obj/item/salvaging_brush/adv = 2, \
		/obj/effect/spawner/random/engineering/tool_advanced = 1, \
	)
	/// Ultimate Rewards - ~5% Chance
	var/static/list/tier3_reward = list(
		/obj/item/stock_parts/capacitor/experimental = 10, \
		/obj/item/stock_parts/matter_bin/anomic = 10, \
		/obj/item/stock_parts/micro_laser/quintuple_bound = 10, \
		/obj/item/stock_parts/scanning_module/prototype = 10, \
		/obj/item/stock_parts/servo/atomic = 10, \
		/obj/item/stack/ore/bananium = 1, \
		/obj/effect/spawner/random/exotic/tool = 1, \
	)

/obj/item/scrap_chunk/Initialize(mapload)
	. = ..()
	create_item()
	create_depth()

/obj/item/scrap_chunk/examine(mob/user)
	. = ..()
	. += span_notice("[scanned ? "This item has been scanned. Max Depth: [max_depth] cm. Safe Depth: [safe_depth] cm." : "This item has not been scanned."]")
	if(adv_scanned)
		. += span_notice("The item depth is [item_depth] cm.")
	. += span_notice("[measured ? "This item has been measured. Dug Depth: [dug_depth]." : "This item has not been measured."]")
	if(measured && dug_depth > item_depth)
		. += span_warning("The chunk is crumbling apart, even just brushing it will destroy it!")

/obj/item/scrap_chunk/proc/create_item()
	choose_tier = rand(1,100)
	switch(choose_tier)
		if(1 to 60)
			hidden_item = pick_weight(tier1_reward)
			choose_tier = REWARD_ONE
		if(61 to 94)
			hidden_item = pick_weight(tier2_reward)
			choose_tier = REWARD_TWO
		if(95 to 100)
			hidden_item = pick_weight(tier3_reward)
			choose_tier = REWARD_THREE

/obj/item/scrap_chunk/proc/create_depth()
	max_depth = rand(21, (22 * choose_tier))
	safe_depth = rand(1, 10)
	item_depth = rand((max_depth - safe_depth), max_depth)
	dug_depth = rand(0, 10)

//returns true if the scrap chunk is measured
/obj/item/scrap_chunk/proc/get_measured()
	if(measured)
		return FALSE
	measured = TRUE
	return TRUE

//returns true if the scrap chunk is scanned
/obj/item/scrap_chunk/proc/get_scanned(use_advanced = FALSE)
	if(scanned)
		if(!adv_scanned && use_advanced)
			adv_scanned = TRUE
			return TRUE
		return FALSE
	scanned = TRUE
	if(use_advanced)
		adv_scanned = TRUE
	return TRUE

/obj/item/scrap_chunk/proc/try_dig(dig_amount)
	if(!dig_amount)
		return DIG_UNDEFINED
	dug_depth += dig_amount
	if(dug_depth > item_depth)
		qdel(src)
		return DIG_DELETE
	return DIG_ROCK

/obj/item/scrap_chunk/proc/try_uncover()
	if(dug_depth > item_depth)
		qdel(src)
		return BRUSH_DELETE
	if(dug_depth == item_depth)
		new hidden_item(get_turf(src))
		qdel(src)
		return BRUSH_UNCOVER
	try_dig(1)
	return BRUSH_NONE

/obj/item/scrap_chunk/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/salvaging_hammer))
		var/obj/item/salvaging_hammer/xeno_hammer = I
		to_chat(user, span_notice("You begin carefully using your hammer to pry off parts of the metal..."))
		if(!do_after(user, xeno_hammer.dig_speed, target = src))
			to_chat(user, span_warning("You interrupt your careful planning, damaging the chunk in the process!"))
			dug_depth += rand(1,5)
			return
		switch(try_dig(xeno_hammer.dig_amount))
			if(DIG_UNDEFINED)
				message_admins("[ADMIN_LOOKUPFLW(user)]'s hammer has somehow pried in a way that shouldn't happen! Tell a coder!")
				return
			if(DIG_DELETE)
				to_chat(user, span_warning("The chunk crumbles away, leaving nothing behind."))
				return
			if(DIG_ROCK)
				to_chat(user, span_notice("You successfully pry further around the relatively interesting part of the chunk."))

	if(istype(I, /obj/item/salvaging_brush))
		var/obj/item/salvaging_brush/xeno_brush = I
		to_chat(user, span_notice("You begin carefully using your brush."))
		if(!do_after(user, xeno_brush.dig_speed, target = src))
			to_chat(user, span_warning("You interrupt your careful planning, damaging the chunk in the process!"))
			dug_depth += rand(1,5)
			return
		switch(try_uncover())
			if(BRUSH_DELETE)
				to_chat(user, span_warning("The chunk crumbles away, leaving nothing behind."))
				return
			if(BRUSH_UNCOVER)
				to_chat(user, span_notice("You successfully brush around the relatively interesting part, and it falls free!"))
				return
			if(BRUSH_NONE)
				to_chat(user, span_notice("You brush around the relatively interesting part, but your search wields no results yet."))

	if(istype(I, /obj/item/salvaging_tape_measure))
		to_chat(user, span_notice("You begin carefully using your measuring tape."))
		if(!do_after(user, 4 SECONDS, target = src))
			to_chat(user, span_warning("You interrupt your careful planning, damaging the chunk in the process!"))
			dug_depth += rand(1,5)
			return
		if(get_measured())
			to_chat(user, span_notice("You successfully measure the chunk; noting it's depth against how far it's fallen apart."))
			return
		to_chat(user, span_warning("This chunk has already been measured."))

	if(istype(I, /obj/item/salvage_handheld_scanner))
		var/obj/item/salvage_handheld_scanner/item_scanner = I
		to_chat(user, span_notice("You begin to scan [src] using [item_scanner]."))
		if(!do_after(user, item_scanner.scanning_speed, target = src))
			to_chat(user, span_warning("You interrupt your scanning, damaging the chunk in the process!"))
			dug_depth += rand(1,5)
			return
		if(get_scanned(item_scanner.scan_advanced))
			to_chat(user, span_notice("Your scanner pings; printing the depth of the chunk against how far it's fallen apart!"))
			if(adv_scanned)
				to_chat(user, span_notice("The chunk's depth is already being reported!"))
			return
		to_chat(user, span_warning("The chunk was already scanned."))

#undef DIG_UNDEFINED
#undef DIG_DELETE
#undef DIG_ROCK

#undef BRUSH_DELETE
#undef BRUSH_UNCOVER
#undef BRUSH_NONE

#undef REWARD_ONE
#undef REWARD_TWO
#undef REWARD_THREE
