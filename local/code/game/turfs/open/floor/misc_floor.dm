/turf/open/floor
	icon = EFFIGY_TURFS_ICON_FILE

/turf/open/floor/circuit
	icon = EFFIGY_TURFS_ICON_FILE

/turf/open/chasm/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	underlay_appearance.icon = EFFIGY_TURFS_ICON_FILE
	underlay_appearance.icon_state = "basalt"
	return TRUE
