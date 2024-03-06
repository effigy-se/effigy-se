/obj/structure/window
	icon = 'local/icons/obj/structures.dmi'

/obj/structure/window/fulltile
	icon = 'local/icons/obj/smooth_structures/window.dmi'

/obj/structure/window/reinforced/fulltile
	icon = 'local/icons/obj/smooth_structures/reinforced_window.dmi'

/obj/structure/window/reinforced/tinted/fulltile
	icon = 'local/icons/obj/smooth_structures/reinforced_window.dmi'

/turf/closed/indestructible/fakeglass
	icon = 'local/icons/obj/smooth_structures/reinforced_window.dmi'

/obj/structure/window/plasma/fulltile
	icon = 'local/icons/obj/smooth_structures/plasma_window.dmi'

/obj/structure/window/reinforced/plasma/fulltile
	icon = 'local/icons/obj/smooth_structures/rplasma_window.dmi'

/obj/structure/window/reinforced/titanium
	name = "titanium window"
	desc = "A window made out of a titanium-silicate alloy. It looks tough to break. Is that a challenge?"
	icon = 'local/icons/obj/smooth_structures/tram_window.dmi'
	icon_state = "tram_mid"
	smoothing_flags = SMOOTH_BITMASK|SMOOTH_BORDER_OBJECT
	canSmoothWith = SMOOTH_GROUP_WINDOW_DIRECTIONAL_TRAM
	smoothing_groups = SMOOTH_GROUP_WINDOW_DIRECTIONAL_TRAM
	reinf = TRUE
	heat_resistance = 1600
	armor_type = /datum/armor/window_titanium
	max_integrity = 100
	explosion_block = 0
	glass_type = /obj/item/stack/sheet/titaniumglass
	rad_insulation = RAD_MEDIUM_INSULATION
	glass_material_datum = /datum/material/alloy/titaniumglass

/obj/structure/window/reinforced/titanium/Initialize(mapload, direct)
	. = ..()
	setDir(dir)

/obj/structure/window/reinforced/titanium/setDir(new_dir)
	. = ..()
	if(fulltile)
		return
	if(dir & NORTH)
		layer = LOW_ITEM_LAYER
	else
		layer = BELOW_OBJ_LAYER
	if(dir & SOUTH)
		SET_PLANE_IMPLICIT(src, WALL_PLANE)
	else
		SET_PLANE_IMPLICIT(src, GAME_PLANE)

/obj/structure/window/reinforced/titanium/set_smoothed_icon_state(new_junction)
	if(fulltile)
		return ..()
	smoothing_junction = new_junction
	var/go_off = reverse_ndir(smoothing_junction)
	var/smooth_left = (go_off & turn(dir, 90))
	var/smooth_right = (go_off & turn(dir, -90))
	if(smooth_left && smooth_right)
		icon_state = "tram_mid"
	else if (smooth_left)
		icon_state = "tram_left"
	else if (smooth_right)
		icon_state = "tram_right"
	else
		icon_state = "tram_mid"
/datum/armor/window_titanium
	melee = 80
	bullet = 5
	bomb = 45
	fire = 99
	acid = 100

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/window/reinforced/titanium, 0)
