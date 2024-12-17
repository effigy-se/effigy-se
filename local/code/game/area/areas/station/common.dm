/area/station/commons/cryo
	name = "Cryogenics Quarters"
	icon_state = "crew_quarters"

/area/station/commons/cryo/on_joining_game(mob/living/boarder)
	var/atom/movable/screen/splash/Spl = new(null, boarder.client, TRUE)
	Spl.Fade(TRUE)
	boarder.playsound_local(get_turf(boarder), 'local/sound/jingles/LatejoinCryo.ogg', 75)
