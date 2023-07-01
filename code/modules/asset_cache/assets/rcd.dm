/datum/asset/spritesheet/rcd
	name = "rcd-tgui"

/datum/asset/spritesheet/rcd/create_spritesheets()
	//We load airlock icons seperatly from other icons cause they need overlays

	//load all category essential icon_states. format is icon_file = list of icon states we need from that file
	var/list/essentials = list(
		'icons/obj/chairs.dmi' = list("bar"),
		'icons/obj/firealarm.dmi' = list("fire_bitem"),
		'icons/obj/lighting.dmi' = list("floodlight_c1"),
		'icons/obj/monitors.dmi' = list("alarm_bitem"),
		'icons/obj/wallframe.dmi' = list("apc"),
		'icons/obj/stock_parts.dmi' = list("box_1"),
		'icons/obj/objects.dmi' = list("bed"),
		'icons/obj/smooth_structures/catwalk.dmi' = list("catwalk-0"),
		'icons/hud/radial.dmi' = list("cnorth", "csouth", "ceast", "cwest", "chair", "secure_windoor", "stool", "wallfloor", "windowsize", "windowtype", "windoor"),
		'icons/obj/structures.dmi' = list("glass_table", "rack", "rwindow0", "reflector_base", "table", "window0"),
	)

	var/icon/icon
	for(var/icon_file as anything in essentials)
		for(var/icon_state as anything in essentials[icon_file])
			icon = icon(icon = icon_file, icon_state = icon_state)
			if(icon_state == "window0" || icon_state == "rwindow0")
				icon.Blend(icon(icon = 'icons/obj/structures.dmi', icon_state = "grille"), ICON_UNDERLAY)
			Insert(sprite_name = sanitize_css_class_name(icon_state), I = icon)

	//for each airlock type we create its overlayed version with the suffix Glass in the sprite name
	//EFFIGY EDIT START - Updated airlock sprites for RCD
	var/list/airlocks = list(
		"Standard" = 'local/icons/obj/airlock/station/generic.dmi',
		"Public" = 'local/icons/obj/airlock/station2/glass.dmi',
		"Engineering" = 'local/icons/obj/airlock/station/engi.dmi',
		"Atmospherics" = 'local/icons/obj/airlock/station/atmos.dmi',
		"Security" = 'local/icons/obj/airlock/station/sec.dmi',
		"Command" = 'local/icons/obj/airlock/station/com.dmi',
		"Medical" = 'local/icons/obj/airlock/station/med.dmi',
		"Research" = 'local/icons/obj/airlock/station/rnd.dmi',
		"Freezer" = 'icons/obj/doors/airlocks/station/freezer.dmi',
		"Virology" = 'local/icons/obj/airlock/station/viro.dmi',
		"Mining" = 'local/icons/obj/airlock/station/cargo.dmi',
		"Maintenance" = 'local/icons/obj/airlock/station/maint-int.dmi',
		"External" = 'icons/obj/doors/airlocks/external/external.dmi',
		"External Maintenance" = 'local/icons/obj/airlock/station/maint-ext.dmi',
		"Airtight Hatch" = 'icons/obj/doors/airlocks/hatch/centcom.dmi',
		"Maintenance Hatch" = 'icons/obj/doors/airlocks/hatch/maintenance.dmi'
	)
	//EFFIGY EDIT END
	//these 3 types dont have glass doors
	var/list/exclusion = list("Freezer", "Airtight Hatch", "Maintenance Hatch")

	for(var/airlock_name in airlocks)
		//solid door with overlay
		icon = icon(icon = airlocks[airlock_name] , icon_state = "closed" , dir = SOUTH)
		icon.Blend(icon(icon = airlocks[airlock_name], icon_state = "fill_closed", dir = SOUTH), ICON_OVERLAY)
		Insert(sprite_name = sanitize_css_class_name(airlock_name), I = icon)

		//exclude these glass types
		if(airlock_name in exclusion)
			continue

		//glass door no overlay
		icon = icon(airlocks[airlock_name] , "closed" , SOUTH)
		Insert(sprite_name = sanitize_css_class_name("[airlock_name]Glass"), I = icon)
