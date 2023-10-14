/datum/map_generator/cave_generator/jungle
	weighted_open_turf_types = list(/turf/open/misc/dirt/jungle = 10, /turf/open/misc/dirt/jungle/dark = 1)
	weighted_closed_turf_types = list(/turf/closed/mineral/random/jungle = 1)
	weighted_mob_spawn_list = list(
		null,
	) // Jungle mobs are.. a bit too on the deadcode and strong as hell side to just have spawning.

	weighted_flora_spawn_list = list(
		/obj/structure/flora/grass/jungle/a/style_random = 1,
		/obj/structure/flora/grass/jungle/b/style_random = 2,
		/obj/structure/flora/bush/jungle/a/style_random = 2,
		/obj/structure/flora/bush/jungle/b/style_random = 2,
		/obj/structure/flora/bush/jungle/c/style_random = 2,
		/obj/structure/flora/bush/large/style_random = 2,
		/obj/structure/flora/rock/pile/jungle/style_random = 2,
	)

	smoothing_iterations = 50
