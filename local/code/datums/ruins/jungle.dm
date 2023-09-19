// Hey! Listen! Update \config\jungleruinblacklist.txt with your new ruins!
// has_ceiling = TRUE for any ruin with an interior

/datum/map_template/ruin/jungle
	ruin_type = ZTRAIT_JUNGLE_RUINS
	prefix = "_maps/RandomRuins/JungleRuins/"
	default_area = /area/taeloth/unexplored
	cost = 1
	allow_duplicates = FALSE

/datum/map_template/ruin/jungle/luna
	id = "luna"
	suffix = "luna.dmm"
	name = "LUNA"
	description = "The dream of a dead dreamer."

/datum/map_template/ruin/jungle/fountain
	name = "Fountain Hall"
	id = "jungle_fountain"
	description = "The fountain has a warning on the side. DANGER: May have undeclared side effects that only become obvious when implemented."
	prefix = "_maps/RandomRuins/AnywhereRuins/"
	suffix = "fountain_hall.dmm"
