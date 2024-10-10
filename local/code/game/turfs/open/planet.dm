/// tl;dr, /tg/ has jungle dirt apply a goofy slowdown that's only apropriate usecase is in one (1) lavaland ruin
/// every time rimpoint has been picked on a populated round someone takes it upon themselves to KILL all the dirt tiles because of this,
/// and IMO that ruins the aesthetic over something small and stupid. To keep their speed consistent with grass; we're overriding to
/// match grass' slowdown directly, to futureproof just slightly.
/// We're also setting the baseturfs to be self-referential as a futureproofing thingamajig. Overrides what /tg/ made them in chasms.jungle

/turf/open/misc/dirt
	baseturfs = /turf/open/misc/dirt

/turf/open/misc/dirt/jungle
	baseturfs = /turf/open/misc/dirt/jungle
	slowdown = /turf/open/misc/grass/jungle::slowdown

/turf/open/misc/dirt/jungle/dark
	baseturfs = /turf/open/misc/dirt/jungle/dark

/turf/open/misc/dirt/dark
	baseturfs = /turf/open/misc/dirt/dark

/// this one is even a fuckin' dupe of jungle/dark but lol
/turf/open/misc/dirt/dark/jungle
	baseturfs = /turf/open/misc/dirt/dark/jungle
	slowdown = /turf/open/misc/grass/jungle::slowdown

/turf/open/misc/dirt/jungle/wasteland
	baseturfs = /turf/open/misc/dirt/jungle/wasteland

/// Used to punish trying to cheese the map
/turf/open/misc/grass/jungle/out_of_bounds/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	if(arrived.anchored)
		return // they must stay
	if(isliving(arrived))
		var/mob/living/to_beat_up = arrived
		to_beat_up.apply_damage(50, BRUTE)
		to_chat(to_beat_up,span_warning("You choke as you enter the smog of the forest - only to re-emerge elsewhere..."))
	if(!isdead(arrived))
		var/potential_spawn = find_space_spawn()
		if(!potential_spawn)
			potential_spawn = get_safe_random_station_turf() /// No carpspawns? Fuggit; random safe tile. This will probably loop for a while..
		arrived.forceMove(potential_spawn)
