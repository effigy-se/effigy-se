/obj/structure/window/reinforced/titanium
	name = "titanium window"
	desc = "A window made out of a titanium-silicate alloy. It looks tough to break. Is that a challenge?"
	icon = 'icons/obj/smooth_structures/windows/tram_thindow.dmi'
	icon_state = "window"
	smoothing_flags = SMOOTH_BITMASK|SMOOTH_BORDER_OBJECT
	canSmoothWith = SMOOTH_GROUP_TRAM_STRUCTURE
	smoothing_groups = SMOOTH_GROUP_TRAM_STRUCTURE
	reinf = TRUE
	heat_resistance = 1600
	armor_type = /datum/armor/window_titanium
	max_integrity = 100
	explosion_block = 0
	glass_type = /obj/item/stack/sheet/titaniumglass
	rad_insulation = RAD_MEDIUM_INSULATION
	glass_material_datum = /datum/material/alloy/titaniumglass

/datum/armor/window_titanium
	melee = 80
	bullet = 5
	bomb = 45
	fire = 99
	acid = 100

MAPPING_DIRECTIONAL_HELPERS_EMPTY(/obj/structure/window/reinforced/titanium)
