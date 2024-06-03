/obj/structure/scrap
	name = "scrap pile"
	desc = "A pile of debris, thrown in a loose pile. There may be valuables, ore, or just junk in it."
	icon = 'local/icons/obj/scrap.dmi'
	icon_state = "scrap"
	anchored = TRUE
	var/list/ways = list("pokes around in", "searches", "scours", "digs through", "rummages through", "goes through","picks through")
	var/list/oreslistcommon = list(
		/obj/item/stack/ore/iron,
		/obj/item/stack/ore/glass
	)

	var/list/oreslistrare = list(
		/obj/item/stack/ore/plasma,
		/obj/item/stack/ore/silver,
		/obj/item/stack/ore/gold,
		/obj/item/stack/ore/diamond,
		/obj/item/stack/ore/titanium,
		/obj/item/stack/ore/plasma
	)

	var/list/partslist = list(
		/obj/item/stock_parts/capacitor/experimental, \
		/obj/item/stock_parts/scanning_module/prototype, \
		/obj/item/stock_parts/servo/atomic, \
		/obj/item/stock_parts/micro_laser/quintuple_bound, \
		/obj/item/stock_parts/matter_bin/anomic, \
	) // SHOG TODO : tier 5

/obj/structure/scrap/examine(mob/user)
	.=..()
	. += span_notice("Some cutting equipment would be ideal to cut through this for valuables, though a shovel will work in a pinch.")

/obj/structure/scrap/attackby(obj/item/tool, mob/user, params)
	// We check here if we have a shovel, OR a valid welding tool.
	if(tool.tool_behaviour == TOOL_SHOVEL || tool.tool_behaviour == TOOL_WELDER && tool.tool_start_check(user, amount=0))
		user.visible_message(span_notice("[user] [pick(ways)] \the [src]..."))
		// If the tool works, we spawn loot and delete the scrap pile.
		if(tool.use_tool(src, user, 150, volume = 100))
			user.visible_message(span_notice("[user] [pick(ways)] what remains of \the [src]."))
			var/list/trash_types = subtypesof(/obj/item/trash)
			var/list/part_types = partslist.Copy()
			// 95% chance to get ore of some sort.
			if (prob(95))
				// An additional 70% chance to get Iron, Glass, and some common ore.
				if (prob(70))
					new /obj/item/stack/ore/iron(get_turf(src))
					new /obj/item/stack/ore/glass(get_turf(src))
					for(var/i in 1 to 5)
						var/oreloot = pick(oreslistcommon)
						new oreloot(get_turf(src))
				// 30% chance to get rare ore instead.
				else
					for(var/i in 1 to 2)
						var/orelootrare = pick(oreslistrare)
						new orelootrare(get_turf(src))
			// 5% chance to get some parts instead.
			else
				for(var/i in 1 to 3)
					var/parts = pick_n_take(part_types)
					new parts(get_turf(src))
			// But there will ALWAYS be trash.
			for(var/i in 1 to 3)
				var/trash = pick_n_take(trash_types)
				new trash(get_turf(src))
			qdel(src)

/obj/structure/scrap/falls_when_spawned/Initialize(mapload)
	. = ..()
	fall_animation()

/obj/structure/scrap/falls_when_spawned/proc/fall_animation()
		pixel_x = rand(-150, 150)
		pixel_y = 500
		var/potential_seconds = rand(2, 4) SECONDS
		animate(src, pixel_y = initial(pixel_y), pixel_x = initial(pixel_x), time = potential_seconds)
		addtimer(CALLBACK(src, PROC_REF(end_fall)), potential_seconds)

/obj/structure/scrap/falls_when_spawned/proc/end_fall()
	for(var/atom/movable/potential_am in loc)
		if(potential_am != src)
			potential_am.ex_act(1)

	for(var/mob/living/M in oviewers(6, src))
		shake_camera(M, 2, 2)
	playsound(loc, 'sound/effects/meteorimpact.ogg', 50, 1)
