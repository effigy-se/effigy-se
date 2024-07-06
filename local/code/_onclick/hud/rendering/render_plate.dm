/atom/movable/screen/plane_master/rendering_plate/game_plate/Initialize(mapload, datum/hud/hud_owner)
	. = ..()
	add_filter("effigy_matrix_value", 2, color_matrix_filter(color_matrix_saturation(1.17)))

/datum/client_colour/effigy
	colour = list(1.01,-0.02,0.04,0, 0.02,0.99,0.02,0, 0,0,1.06,0, 0,0,0,1, 0,0,0,0)
	priority = 998

/mob/Initialize(mapload)
	. = ..()
	add_client_colour(/datum/client_colour/effigy)
