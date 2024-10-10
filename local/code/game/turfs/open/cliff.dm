/// Rocky cliff!
/turf/open/cliff/rock_taeloth
	icon_state = "rock_cliff-0"
	icon = 'local/icons/turf/cliff/rock_cliff.dmi'
	base_icon_state = "rock_cliff"

	smoothing_flags = SMOOTH_BITMASK | SMOOTH_BORDER
	smoothing_groups = SMOOTH_GROUP_TURF_OPEN_CLIFF
	canSmoothWith = SMOOTH_GROUP_TURF_OPEN_CLIFF
	layer = EDGED_TURF_LAYER
	plane = WALL_PLANE

	// This is static
	// Done like this to avoid needing to make it dynamic and save cpu time
	// 4 to the left, 4 down
	transform = MAP_SWITCH(TRANSLATE_MATRIX(-4, -4), matrix())

	undertile_pixel_x = 4
	undertile_pixel_y = 4

	underlay_tile = /turf/open/misc/grass/jungle
	underlay_plane = FLOOR_PLANE

/turf/open/cliff/rock_taeloth/dirt_underlay
	underlay_tile = /turf/open/misc/dirt/jungle

/turf/open/cliff/rock_taeloth/stone_underlay
	underlay_tile = /turf/open/misc/rough_stone
