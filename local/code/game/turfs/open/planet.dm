/// tl;dr, /tg/ has jungle dirt apply a goofy slowdown that's only apropriate usecase is in one (1) lavaland ruin
/// every time rimpoint has been picked on a populated round someone takes it upon themselves to KILL all the dirt tiles because of this,
/// and IMO that ruins the aesthetic over something small and stupid. To keep their speed consistent with grass; we're overriding to
/// match grass' slowdown directly, to futureproof just slightly.
/turf/open/misc/dirt/jungle
	slowdown = /turf/open/misc/grass/jungle::slowdown

/// this one is even a fuckin' dupe of jungle/dark but lol
/turf/open/misc/dirt/dark/jungle
	slowdown = /turf/open/misc/grass/jungle::slowdown
