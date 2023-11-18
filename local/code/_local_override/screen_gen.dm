/atom/movable/screen
	icon = GENERAL_SCREEN_ICONS

/atom/movable/screen/action_landing
	icon = GENERAL_SCREEN_ICONS

/atom/movable/screen/click_catcher
	icon = GENERAL_SCREEN_ICONS

/atom/movable/screen/palette_scroll
	icon = GENERAL_SCREEN_ICONS

/atom/movable/screen/zone_sel
	overlay_icon = GENERAL_SCREEN_ICONS

/obj/effect/overlay/zone_sel
	icon = GENERAL_SCREEN_ICONS

/obj/effect/temp_visual/point
	icon = GENERAL_SCREEN_ICONS

/datum/asset/simple/body_zones/add_limb(limb)
	assets[SANITIZE_FILENAME("body_zones.[limb].png")] = icon(GENERAL_SCREEN_ICONS, limb)
