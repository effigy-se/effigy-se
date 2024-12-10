/area/centcom/interlink
	name = "The Interlink"

/area/centcom/interlink/transit_line
	name = "The Interlink - Transit Line"

/area/centcom/interlink/transit_line/on_joining_game(mob/living/boarder)
	var/atom/movable/screen/splash/Spl = new(null, boarder.client, TRUE)
	Spl.Fade(TRUE)
	boarder.playsound_local(get_turf(boarder), 'local/sound/jingles/LatejoinInterlink.ogg', 75)

/area/centcom/interlink/venue
	name = "The Interlink - Event Venue"
