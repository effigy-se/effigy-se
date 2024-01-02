/turf/open/floor/carpet
	icon = 'icons/turf/floors/carpet_purple.dmi'
	icon_state = "carpet_purple-255"
	base_icon_state = "carpet_purple"
	floor_tile = /obj/item/stack/tile/carpet/purple
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN + SMOOTH_GROUP_CARPET_PURPLE
	canSmoothWith = SMOOTH_GROUP_CARPET_PURPLE

/turf/open/floor/carpet/lone
	icon = 'icons/turf/floors/floor_variations.dmi'

/turf/open/floor/fakebasalt
	icon = EFFIGY_TURFS_ICON_FILE

/turf/open/floor/fakepit/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = EFFIGY_TURFS_ICON_FILE
	underlay_appearance.icon_state = "basalt"
	return TRUE
